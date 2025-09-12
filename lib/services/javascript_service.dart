import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:path_provider/path_provider.dart';
import '../data/models/service_metadata.dart';
import '../data/models/search_result.dart';
import 'http_service.dart';
import 'service_manager.dart';

class JavaScriptService {
  static JavaScriptService? _instance;
  static JavaScriptService get instance {
    _instance ??= JavaScriptService._internal();
    return _instance!;
  }

  JavaScriptService._internal();

  final Logger _logger = Logger();
  bool _isInitialized = false;
  String _currentScript = '';
  
  // Service-specific JavaScript runtime environments to prevent script conflicts
  final Map<String, JavascriptRuntime> _serviceRuntimes = {};
  
  // Script cache: URL -> script content
  final Map<String, String> _scriptCache = {};
  
  // Track which scripts have been loaded into which runtimes to avoid re-evaluation
  final Map<String, bool> _scriptsLoadedInRuntime = {};
  

  Future<void> initialize() async {
    _isInitialized = true;
    _logger.i('JavaScript service initialized - runtimes will be created per service');
  }
  
  // Get or create a service-specific JavaScript runtime
  JavascriptRuntime _getServiceRuntime(String serviceId) {
    if (!_serviceRuntimes.containsKey(serviceId)) {
      _logger.i('Creating new JavaScript runtime for service: $serviceId');
      final runtime = getJavascriptRuntime(
        forceJavascriptCoreOnAndroid: true,
        extraArgs: {
          'stackSize': 2048 * 1024,
        }
      );
      _setupJavaScriptEnvironmentForRuntime(runtime);
      _serviceRuntimes[serviceId] = runtime;
    }
    return _serviceRuntimes[serviceId]!;
  }

  void _setupJavaScriptEnvironmentForRuntime(JavascriptRuntime jsRuntime) {
    // Set up fetchv2 message handler for this specific runtime
    _logger.i('🔧 Setting up fetchv2_request handler for runtime');
    jsRuntime.onMessage('fetchv2_request', (dynamic args) async {
      _logger.i('🌟 fetchv2_request message handler triggered!');
      try {
        _logger.i('🌐 fetchv2 request received: ${args.toString()}');
        // args is already a Map, not a JSON string
        Map<String, dynamic> requestData;
        if (args is String) {
          _logger.i('🔧 Received string args, parsing JSON');
          requestData = json.decode(args);
        } else if (args is Map) {
          _logger.i('🔧 Received Map args directly');
          requestData = Map<String, dynamic>.from(args);
        } else {
          _logger.e('🔧 Unexpected args type: ${args.runtimeType}');
          requestData = {'error': 'Invalid args type'};
        }
        
        final String requestId = requestData['requestId'] ?? '';
        final String url = requestData['url'] ?? '';
        final String method = requestData['method'] ?? 'GET';
        final Map<String, dynamic> headers = Map<String, dynamic>.from(requestData['headers'] ?? {});
        final String? body = requestData['body'];

        _logger.i('🌐 Processing fetchv2 request: $method $url');

        try {
          final response = await HttpService.instance.dartFetchV2(
            url: url,
            method: method,
            headers: headers,
            body: body,
          );
          
          _logger.i('🌐 HTTP request successful, calling JavaScript callback for $requestId');
          
          // Call JavaScript callback with success result
          jsRuntime.evaluate('''
            console.log('Resolving fetchv2 callback for request: $requestId');
            console.log('fetchv2_callbacks exists:', typeof fetchv2_callbacks !== 'undefined');
            console.log('callback exists for $requestId:', typeof fetchv2_callbacks !== 'undefined' && fetchv2_callbacks['$requestId'] !== undefined);
            if (typeof fetchv2_callbacks !== 'undefined' && fetchv2_callbacks['$requestId']) {
              console.log('Calling resolve for request: $requestId');
              fetchv2_callbacks['$requestId'].resolve({
                status: 200,
                headers: {},
                body: ${json.encode(response)},
                text: function() { return Promise.resolve(${json.encode(response)}); },
                json: function() { 
                  try { 
                    return Promise.resolve(JSON.parse(${json.encode(response)})); 
                  } catch(e) { 
                    return Promise.reject(new Error('JSON parse error')); 
                  } 
                }
              });
              delete fetchv2_callbacks['$requestId'];
              console.log('fetchv2 callback resolved and deleted successfully');
            } else {
              console.log('fetchv2 callback not found for request: $requestId');
              console.log('Available callbacks:', Object.keys(fetchv2_callbacks || {}));
            }
          ''');
        } catch (e) {
          _logger.e('fetchv2 request error: $e');
          // Call JavaScript callback with error result
          jsRuntime.evaluate('''
            if (typeof fetchv2_callbacks !== 'undefined' && fetchv2_callbacks['$requestId']) {
              fetchv2_callbacks['$requestId'].reject(new Error(${json.encode(e.toString())}));
              delete fetchv2_callbacks['$requestId'];
            }
          ''');
        }
        
        return 'OK';
      } catch (e) {
        _logger.e('fetchv2 handler error: $e');
        return 'ERROR: $e';
      }
    });

    // Set up test message handler BEFORE sending test message
    jsRuntime.onMessage('test_message', (args) {
      _logger.i('🎯 Test message received in Dart: $args');
      return 'Test response from Dart';
    });

    // Test basic message passing now that handler is registered
    jsRuntime.evaluate('''
      console.log('Testing sendMessage function...');
      if (typeof sendMessage === 'function') {
        console.log('sendMessage function exists, testing...');
        try {
          sendMessage('test_message', 'Hello from JavaScript');
          console.log('Test message sent successfully');
        } catch (e) {
          console.log('Test message failed:', e);
        }
      } else {
        console.log('sendMessage function does not exist!');
      }
    ''');

    // Set up fetchv2 JavaScript function
    jsRuntime.evaluate('''
      var fetchv2_callbacks = {};
      var fetchv2_request_id = 0;
      
      function fetchv2(url, headers = {}, method = "GET", body = null, redirect = true, encoding) {
        console.log('fetchv2 called with URL:', url, 'method:', method);
        return new Promise(function(resolve, reject) {
          var requestId = 'req_' + (++fetchv2_request_id);
          
          fetchv2_callbacks[requestId] = {
            resolve: resolve,
            reject: reject
          };
          
          var requestData = {
            requestId: requestId,
            url: url,
            method: method || 'GET',
            headers: headers || {},
            body: body
          };
          
          console.log('Sending fetchv2 request (stringified):', JSON.stringify(requestData));
          console.log('sendMessage function exists:', typeof sendMessage !== 'undefined');
          sendMessage('fetchv2_request', JSON.stringify(requestData));
        });
      }
    ''');
  }

  Future<List<SearchItem>> search(String keyword, Service service) async {
    if (!_isInitialized) await initialize();

    try {
      _logger.i('🔍 Searching for "$keyword" using ${service.metadata.sourceName}');

      // Load the service script from local file
      final scriptContent = await _loadServiceScriptFromLocal(service);

      // Execute search function in JavaScript with service-specific runtime
      final jsRuntime = _getServiceRuntime(service.id);
      final result = await _executeSearchWithRuntime(keyword, scriptContent, jsRuntime);
      
      // Debug info removed for cleaner output
      
      // Handle both String and List results
      List<dynamic>? resultList;
      
      if (result is List) {
        resultList = result;
      } else if (result is String && result.isNotEmpty) {
        try {
          final decoded = json.decode(result);
          if (decoded is List) {
            resultList = decoded;
          }
        } catch (e) {
          _logger.e('❌ Failed to decode search string result: $e');
        }
      }
      
      if (resultList != null && resultList.isNotEmpty) {
        _logger.i('✅ Found ${resultList.length} search results');
        return resultList.map<SearchItem>((item) => SearchItem(
          title: item['title'] ?? 'Unknown Title',
          href: item['href'] ?? '',
          imageUrl: item['image'] ?? '',
        )).toList();
      } else {
        _logger.d('No search results found');
        return [];
      }

    } catch (e) {
      _logger.e('💥 Search failed: $e');
      throw Exception('Search failed: $e');
    }
  }

  Future<List<SearchItem>> searchWithMetadata(String keyword, ServiceMetadata service) async {
    if (!_isInitialized) await initialize();

    final serviceKey = '${service.sourceName}_${service.scriptUrl}';
    try {
      _logger.i('🔍 Searching for "$keyword" using ${service.sourceName}');

      // Load the service script
      await _loadServiceScript(service);

      // Execute search function in JavaScript with service-specific runtime
      final jsRuntime = _getServiceRuntime(serviceKey);
      final result = await _executeSearchWithRuntime(keyword, _currentScript, jsRuntime);
      
      // Debug info removed for cleaner output
      
      // Handle both String and List results
      List<dynamic>? resultList;
      
      if (result is List) {
        resultList = result;
      } else if (result is String && result.isNotEmpty) {
        try {
          final decoded = json.decode(result);
          if (decoded is List) {
            resultList = decoded;
          }
        } catch (e) {
          _logger.e('❌ Failed to decode string result: $e');
        }
      }
      
      if (resultList != null && resultList.isNotEmpty) {
        _logger.i('✅ Found ${resultList.length} search results');
        return resultList.map<SearchItem>((item) => SearchItem(
          title: item['title'] ?? 'Unknown Title',
          href: item['href'] ?? '',
          imageUrl: item['image'] ?? '',
        )).toList();
      } else {
        _logger.d('No search results found');
        return [];
      }

    } catch (e) {
      _logger.e('💥 Search failed: $e');
      throw Exception('Search failed: $e');
    }
  }

  Future<void> _loadServiceScript(ServiceMetadata service) async {
    try {
      final scriptUrl = service.scriptUrl;
      
      // Check if script is already cached
      if (_scriptCache.containsKey(scriptUrl)) {
        _currentScript = _scriptCache[scriptUrl]!;
        _logger.i('📜 Using cached script for ${service.sourceName} (${_currentScript.length} chars)');
        return;
      }
      
      _logger.i('📜 Downloading service script: ${service.sourceName} from $scriptUrl');
      
      final scriptContent = await HttpService.instance.fetchServiceScript(scriptUrl);
      _logger.d('Script downloaded (${scriptContent.length} chars)');
      
      if (scriptContent.trim().isEmpty) {
        throw Exception('Downloaded script is empty from $scriptUrl');
      }
      
      // Cache the script content
      _scriptCache[scriptUrl] = scriptContent;
      _currentScript = scriptContent;
      _logger.i('📜 Script cached and loaded successfully for ${service.sourceName}');
      
    } catch (e) {
      _logger.e('💥 Failed to load service script: $e');
      throw Exception('Failed to load service script: $e');
    }
  }

  Future<String> _loadServiceScriptFromLocal(Service service) async {
    try {
      final scriptUrl = service.metadata.scriptUrl;
      
      // Check if script is already cached
      if (_scriptCache.containsKey(scriptUrl)) {
        final scriptContent = _scriptCache[scriptUrl]!;
        _logger.i('📜 Using cached script for ${service.metadata.sourceName} (${scriptContent.length} chars)');
        return scriptContent;
      }
      
      // Try to load from local file first
      final documentsDir = await getApplicationDocumentsDirectory();
      final serviceDir = Directory('${documentsDir.path}/Services/${service.localPath}');
      final scriptFile = File('${serviceDir.path}/script.js');
      
      if (await scriptFile.exists()) {
        final scriptContent = await scriptFile.readAsString();
        if (scriptContent.trim().isNotEmpty) {
          // Cache the script content
          _scriptCache[scriptUrl] = scriptContent;
          _logger.i('📜 Loaded script from local file for ${service.metadata.sourceName} (${scriptContent.length} chars)');
          return scriptContent;
        } else {
          _logger.w('⚠️ Local script file is empty for ${service.metadata.sourceName}');
        }
      } else {
        _logger.w('⚠️ Local script file not found for ${service.metadata.sourceName}: ${scriptFile.path}');
      }
      
      // Fallback to network download if local file doesn't exist or is empty
      _logger.i('📜 Fallback: Downloading script from network for ${service.metadata.sourceName}');
      await _loadServiceScript(service.metadata);
      // Return the cached script after network load
      return _scriptCache[scriptUrl]!;
      
    } catch (e) {
      _logger.e('💥 Failed to load service script from local: $e');
      // Final fallback to network
      try {
        await _loadServiceScript(service.metadata);
        // Return the cached script after network load
        return _scriptCache[service.metadata.scriptUrl]!;
      } catch (networkError) {
        throw Exception('Failed to load script both locally and from network: Local: $e, Network: $networkError');
      }
    }
  }

  // Cache management methods
  void clearScriptCache() {
    _scriptCache.clear();
    _logger.i('🗑️ Script cache cleared');
  }

  void clearScriptCacheForUrl(String scriptUrl) {
    if (_scriptCache.containsKey(scriptUrl)) {
      _scriptCache.remove(scriptUrl);
      _logger.i('🗑️ Script cache cleared for URL: $scriptUrl');
    }
  }

  void clearScriptCacheForService(Service service) {
    final scriptUrl = service.metadata.scriptUrl;
    clearScriptCacheForUrl(scriptUrl);
    // Also dispose of service-specific runtime
    _disposeServiceRuntime(service.id);
  }
  
  // Dispose of a service-specific runtime
  void _disposeServiceRuntime(String serviceId) {
    if (_serviceRuntimes.containsKey(serviceId)) {
      try {
        _serviceRuntimes[serviceId]!.dispose();
        _serviceRuntimes.remove(serviceId);
        _logger.i('Disposed JavaScript runtime for service: $serviceId');
      } catch (e) {
        _logger.w('Failed to dispose runtime for service $serviceId: $e');
      }
    }
  }
  
  int get cachedScriptsCount => _scriptCache.length;
  
  List<String> get cachedScriptUrls => _scriptCache.keys.toList();

  Future<dynamic> _executeSearchWithRuntime(String keyword, String scriptContent, JavascriptRuntime jsRuntime) async {
    try {
      _logger.d('Executing JavaScript search');

      // Generate unique execution ID to avoid conflicts between concurrent searches
      final executionId = DateTime.now().millisecondsSinceEpoch.toString();

      // Clean the script content to prevent syntax errors from appended content
      String cleanedScript = scriptContent;
      const geEndMarker = '/* {GE END} */';
      int markerIndex = cleanedScript.indexOf(geEndMarker);
      if (markerIndex != -1) {
          int endIndex = markerIndex + geEndMarker.length;
          cleanedScript = cleanedScript.substring(0, endIndex);
          _logger.i('✂️ Script content was truncated at GE END marker to prevent syntax errors.');
      }

      // Generate a key to track if this script is loaded in this specific runtime
      final scriptLoadedKey = '${jsRuntime.hashCode}-${cleanedScript.hashCode}';

      // Execute the script that was loaded, but only once per runtime instance
      if (_scriptsLoadedInRuntime[scriptLoadedKey] != true) {
        _logger.i('📜 Executing script content for the first time in this runtime (${cleanedScript.length} chars)');
        jsRuntime.evaluate(cleanedScript);
        _scriptsLoadedInRuntime[scriptLoadedKey] = true;
      } else {
        _logger.i('📜 Script content already evaluated in this runtime, skipping.');
      }
      
      // Check what functions are available after loading the script
      final functionsCheck = jsRuntime.evaluate('''
        (function() {
          var availableFunctions = [];
          if (typeof search === 'function') availableFunctions.push('search');
          if (typeof searchResults === 'function') availableFunctions.push('searchResults');
          if (typeof fetchv2 === 'function') availableFunctions.push('fetchv2');
          if (typeof extractDetails === 'function') availableFunctions.push('extractDetails');
          if (typeof extractEpisodes === 'function') availableFunctions.push('extractEpisodes');
          if (typeof extractStreamUrl === 'function') availableFunctions.push('extractStreamUrl');
          return JSON.stringify(availableFunctions);
        })()
      ''');
      _logger.i('🔧 Available functions after script load: ${functionsCheck.stringResult}');

      // Test basic JavaScript execution first
      try {
        jsRuntime.evaluate('''
          console.log('🔍 Step 1: Basic JavaScript execution test');
        ''');
        _logger.i('✅ Basic JavaScript execution successful');
        
        jsRuntime.evaluate('''
          console.log('🔍 Step 2: Setting up variables');
          var searchPromiseResult_$executionId = null;
          var searchPromiseError_$executionId = null;
          var searchPromiseComplete_$executionId = false;
          console.log('🔍 Step 3: Variables set successfully');
        ''');
        _logger.i('✅ Variable setup successful');
        
        jsRuntime.evaluate('''
          console.log('🔍 Step 4: Function type checking');
          console.log('search type:', typeof search);
          console.log('searchResults type:', typeof searchResults);  
          console.log('fetchv2 type:', typeof fetchv2);
          console.log('🔍 Step 5: Function check complete');
          
          if (typeof searchResults === 'function') {
            console.log('🔍 Step 6: Found searchResults function, calling now...');
            try {
              var results = searchResults("$keyword");
              console.log('🔍 Step 7: searchResults returned:', results);
              if (results && results.then) {
                console.log('🔍 Step 8: Results is a promise, awaiting...');
                results.then(function(data) {
                  console.log('🔍 Step 9: Promise resolved with:', data);
                  searchPromiseResult_$executionId = JSON.stringify(data);
                  searchPromiseComplete_$executionId = true;
                }).catch(function(error) {
                  console.log('🔍 Step 9: Promise rejected with:', error);
                  searchPromiseError_$executionId = error.toString();
                  searchPromiseComplete_$executionId = true;
                });
              } else {
                console.log('🔍 Step 8: Results is not a promise, using directly');
                searchPromiseResult_$executionId = JSON.stringify(results);
                searchPromiseComplete_$executionId = true;
              }
            } catch (error) {
              console.log('🔍 Step 7: Error calling searchResults:', error);
              searchPromiseError_$executionId = error.toString();
              searchPromiseComplete_$executionId = true;
            }
          } else {
            console.log('🔍 Step 6: No searchResults function found');
            searchPromiseError_$executionId = 'No searchResults function found';
            searchPromiseComplete_$executionId = true;
          }
          console.log('🔍 Step 7: Test complete');
        ''');
        _logger.i('✅ Function checking successful');
        
      } catch (e) {
        _logger.e('❌ JavaScript execution failed: $e');
        return [];
      }

      // Poll for completion - with JavaScriptCore, Android should perform similarly to other platforms
      final maxIterations = 400; // 40 seconds timeout for all platforms
      final pollInterval = 100; // 100ms polling interval
      
      for (int i = 0; i < maxIterations; i++) {
        await Future.delayed(Duration(milliseconds: pollInterval));
        
        final completeResult = jsRuntime.evaluate('searchPromiseComplete_$executionId');
        if (completeResult.stringResult == 'true') {
          final errorResult = jsRuntime.evaluate('searchPromiseError_$executionId');
          final errorString = errorResult.stringResult;
          if (errorString.isNotEmpty && errorString != 'null' && errorString != 'undefined') {
            throw Exception('JavaScript search error: $errorString');
          }
          
          final dataResult = jsRuntime.evaluate('searchPromiseResult_$executionId');
          _logger.i('🔍 Raw dataResult: ${dataResult.toString()}');
          _logger.i('🔍 stringResult: "${dataResult.stringResult}"');
          _logger.i('🔍 rawResult: ${dataResult.rawResult}');
          
          // Try multiple ways to get the result
          String? resultString;
          if (dataResult.stringResult.isNotEmpty) {
            resultString = dataResult.stringResult;
          } else if (dataResult.rawResult != null) {
            resultString = dataResult.rawResult.toString();
          }
          
          _logger.i('🔍 Final resultString: "$resultString"');
          
          if (resultString != null && resultString.isNotEmpty && resultString != 'null') {
            try {
              final searchResults = json.decode(resultString);
              _logger.i('🔍 Parsed searchResults: $searchResults');
              
              // Cleanup execution-specific variables
              jsRuntime.evaluate('''
                delete window.searchPromiseResult_$executionId;
                delete window.searchPromiseError_$executionId;
                delete window.searchPromiseComplete_$executionId;
              ''');
              
              return searchResults;
            } catch (e) {
              _logger.e('❌ Failed to parse search results: $e');
              throw Exception('Failed to parse search results: $e');
            }
          }
          break;
        }
      }
      
      // Cleanup on timeout
      jsRuntime.evaluate('''
        delete window.searchPromiseResult_$executionId;
        delete window.searchPromiseError_$executionId;
        delete window.searchPromiseComplete_$executionId;
      ''');
      
      _logger.w('⏰ Search timed out after 40 seconds');
      return [];
    } catch (e) {
      _logger.e('❌ Search execution failed: $e');
      throw Exception('Search execution failed: $e');
    }
  }

  Future<MediaItem> extractDetails(String url) async {
    if (!_isInitialized) await initialize();

    try {
      _logger.i('📋 Extracting details from $url');
      
      // Set up Promise result variable and execute extractDetails
      // Note: This method needs to be updated to use service-specific runtime
      // For now, create a temporary runtime (this will be updated later)
      final jsRuntime = getJavascriptRuntime(forceJavascriptCoreOnAndroid: true);
      _setupJavaScriptEnvironmentForRuntime(jsRuntime);
      jsRuntime.evaluate('''
        var detailsPromiseResult = null;
        var detailsPromiseError = null;
        var detailsPromiseComplete = false;
        
        (async function() {
          try {
            if (typeof extractDetails === 'function') {
              const details = await extractDetails('$url');
              detailsPromiseResult = typeof details === 'string' ? details : JSON.stringify(details);
              detailsPromiseComplete = true;
            } else {
              detailsPromiseError = 'extractDetails function not found';
              detailsPromiseComplete = true;
            }
          } catch (error) {
            detailsPromiseError = error.toString();
            detailsPromiseComplete = true;
          }
        })();
      ''');

      // Poll for completion
      for (int i = 0; i < 300; i++) { // 30 seconds timeout
        await Future.delayed(const Duration(milliseconds: 100));
        
        final completeResult = jsRuntime.evaluate('detailsPromiseComplete');
        if (completeResult.stringResult == 'true') {
          final errorResult = jsRuntime.evaluate('detailsPromiseError');
          if (errorResult.stringResult.isNotEmpty) {
            throw Exception('JavaScript extractDetails error: ${errorResult.stringResult}');
          }
          
          final dataResult = jsRuntime.evaluate('detailsPromiseResult');
          final resultString = dataResult.stringResult;
          
          if (resultString.isNotEmpty) {
            try {
              final detailsData = json.decode(resultString);
              if (detailsData is Map) {
                return MediaItem(
                  description: detailsData['description'] ?? 'N/A',
                  aliases: detailsData['aliases'] ?? 'N/A',
                  airdate: detailsData['airdate'] ?? 'N/A',
                );
              }
            } catch (e) {
              _logger.e('❌ Failed to parse details: $e');
              rethrow;
            }
          }
          break;
        }
      }
      
      return const MediaItem(
        description: 'N/A',
        aliases: 'N/A',
        airdate: 'N/A',
      );
    } catch (e) {
      _logger.e('💥 Extract details failed: $e');
      throw Exception('Extract details failed: $e');
    }
  }

  Future<List<EpisodeLink>> extractEpisodesWithService(String detailUrl, Service service) async {
    if (!_isInitialized) await initialize();

    try {
      _logger.i('📺 Extracting episodes from $detailUrl');
      
      final scriptContent = await _loadServiceScriptFromLocal(service);
      _currentScript = scriptContent; // For backward compatibility
      
      // Execute extractEpisodes function in JavaScript with service-specific runtime
      final jsRuntime = _getServiceRuntime(service.id);
      final result = await _executeEpisodesExtractionWithRuntime(detailUrl, scriptContent, jsRuntime);
      
      _logger.i('🔍 Episodes result type: ${result.runtimeType}');
      _logger.i('🔍 Episodes result is List? ${result is List}');
      _logger.i('🔍 Episodes result length: ${result is List ? result.length : 'N/A'}');
      
      // Handle both String and List results for episodes
      List<dynamic>? resultList;
      
      if (result is List) {
        resultList = result;
      } else if (result is String && result.isNotEmpty) {
        try {
          final decoded = json.decode(result);
          if (decoded is List) {
            resultList = decoded;
          }
        } catch (e) {
          _logger.e('❌ Failed to decode episodes string result: $e');
        }
      }
      
      if (resultList != null && resultList.isNotEmpty) {
        _logger.i('✅ Found ${resultList.length} episodes');
        return resultList.map<EpisodeLink>((item) => EpisodeLink(
          number: item['number'] ?? 0,
          title: item['title'] ?? 'Episode',
          href: item['href'] ?? '',
        )).toList();
      } else {
        _logger.w('⚠️ No episodes found - result: $result, type: ${result.runtimeType}');
        return [];
      }
    } catch (e) {
      _logger.e('💥 Extract episodes failed: $e');
      throw Exception('Extract episodes failed: $e');
    }
  }

  Future<Map<String, dynamic>> extractStreamUrlWithService(String episodeUrl, Service service) async {
    if (!_isInitialized) await initialize();

    try {
      _logger.i('🎬 Extracting stream URL from $episodeUrl');
      
      final scriptContent = await _loadServiceScriptFromLocal(service);
      _currentScript = scriptContent; // For backward compatibility
      
      // Execute extractStreamUrl function in JavaScript with service-specific runtime
      final jsRuntime = _getServiceRuntime(service.id);
      final result = await _executeStreamUrlExtractionWithRuntime(episodeUrl, scriptContent, jsRuntime);
      
      if (result != null) {
        _logger.i('✅ Stream URL extraction successful');
        return result;
      } else {
        _logger.w('⚠️ No stream found');
        return {
          'streams': [],
          'subtitles': [],
        };
      }
    } catch (e) {
      _logger.e('💥 Extract stream URL failed: $e');
      throw Exception('Extract stream URL failed: $e');
    }
  }

  Future<dynamic> _executeEpisodesExtractionWithRuntime(String detailUrl, String scriptContent, JavascriptRuntime jsRuntime) async {
    try {
      _logger.d('Executing JavaScript episodes extraction');

      // Execute the script that was loaded
      jsRuntime.evaluate(scriptContent);

      // Set up Promise result variable and execute episodes extraction
      jsRuntime.evaluate('''
        var episodesPromiseResult = null;
        var episodesPromiseError = null;
        var episodesPromiseComplete = false;
        
        (async function() {
          try {
            let results;
            if (typeof extractEpisodes === 'function') {
              console.log('Calling extractEpisodes function with URL: $detailUrl');
              results = await extractEpisodes("$detailUrl");
              console.log('ExtractEpisodes function returned:', results);
            } else {
              throw new Error('No extractEpisodes function found');
            }
            episodesPromiseResult = JSON.stringify(results);
            episodesPromiseComplete = true;
            console.log('Episodes extraction completed successfully');
          } catch (error) {
            console.log('Episodes extraction error:', error.toString());
            episodesPromiseError = error.toString();
            episodesPromiseComplete = true;
          }
        })();
      ''');

      // Poll for completion - unified timeout with JavaScriptCore
      final maxIterations = 400; // 40 seconds
      final pollInterval = 100; // 100ms
      
      for (int i = 0; i < maxIterations; i++) {
        await Future.delayed(Duration(milliseconds: pollInterval));
        
        final completeResult = jsRuntime.evaluate('episodesPromiseComplete');
        if (completeResult.stringResult == 'true') {
          final errorResult = jsRuntime.evaluate('episodesPromiseError');
          final errorString = errorResult.stringResult;
          if (errorString.isNotEmpty && errorString != 'null' && errorString != 'undefined') {
            throw Exception('JavaScript episodes extraction error: $errorString');
          }
          
          final dataResult = jsRuntime.evaluate('episodesPromiseResult');
          final resultString = dataResult.stringResult;
          
          if (resultString.isNotEmpty && resultString != 'null') {
            try {
              final episodesResults = json.decode(resultString);
              _logger.i('🔍 Parsed episodes results: $episodesResults');
              return episodesResults;
            } catch (e) {
              _logger.e('❌ Failed to parse episodes results: $e');
              throw Exception('Failed to parse episodes results: $e');
            }
          }
          break;
        }
      }
      
      throw Exception('Episodes extraction timeout');
    } catch (e) {
      _logger.e('💥 Episodes extraction failed: $e');
      throw Exception('Episodes extraction failed: $e');
    }
  }

  Future<Map<String, dynamic>?> _executeStreamUrlExtractionWithRuntime(String episodeUrl, String scriptContent, JavascriptRuntime jsRuntime) async {
    try {
      _logger.d('Executing JavaScript stream extraction');

      // Execute the script that was loaded
      jsRuntime.evaluate(scriptContent);

      // Set up Promise result variable and execute stream URL extraction
      jsRuntime.evaluate('''
        var streamPromiseResult = null;
        var streamPromiseError = null;
        var streamPromiseComplete = false;
        
        (async function() {
          try {
            let results;
            if (typeof extractStreamUrl === 'function') {
              console.log('Calling extractStreamUrl function with URL: $episodeUrl');
              results = await extractStreamUrl("$episodeUrl");
              console.log('ExtractStreamUrl function returned:', results);
            } else {
              throw new Error('No extractStreamUrl function found');
            }
            streamPromiseResult = JSON.stringify(results);
            streamPromiseComplete = true;
            console.log('Stream URL extraction completed successfully');
          } catch (error) {
            console.log('Stream URL extraction error:', error.toString());
            streamPromiseError = error.toString();
            streamPromiseComplete = true;
          }
        })();
      ''');

      // Poll for completion - unified timeout for streaming with JavaScriptCore
      final maxIterations = 600; // 60 seconds for streaming operations
      final pollInterval = 100; // 100ms
      
      for (int i = 0; i < maxIterations; i++) {
        await Future.delayed(Duration(milliseconds: pollInterval));
        
        final completeResult = jsRuntime.evaluate('streamPromiseComplete');
        if (completeResult.stringResult == 'true') {
          final errorResult = jsRuntime.evaluate('streamPromiseError');
          final errorString = errorResult.stringResult;
          if (errorString.isNotEmpty && errorString != 'null' && errorString != 'undefined') {
            throw Exception('JavaScript stream URL extraction error: $errorString');
          }
          
          final dataResult = jsRuntime.evaluate('streamPromiseResult');
          final resultString = dataResult.stringResult;
          
          if (resultString.isNotEmpty && resultString != 'null') {
            try {
              _logger.i('🔍 Raw result string: $resultString');
              _logger.i('🔍 Result string type: ${resultString.runtimeType}');
              _logger.i('🔍 Result string length: ${resultString.length}');
              _logger.i('🔍 First 10 characters: "${resultString.substring(0, 10)}"');
              _logger.i('🔍 Last 10 characters: "${resultString.substring(resultString.length - 10)}"');
              _logger.i('🔍 Starts with {: ${resultString.startsWith('{')}');
              _logger.i('🔍 Ends with }: ${resultString.endsWith('}')}');
              
              // Handle multiple levels of JSON escaping
              String processedString = resultString;
              _logger.i('🔧 Processing result string for multiple escaping levels');
              
              // Remove outer quotes if present
              if (processedString.startsWith('"') && processedString.endsWith('"')) {
                processedString = processedString.substring(1, processedString.length - 1);
                _logger.i('🔧 Removed outer quotes');
              }
              
              // Unescape internal quotes
              processedString = processedString.replaceAll('\\"', '"');
              _logger.i('🔧 Unescaped internal quotes');
              _logger.i('🔧 Final processed string: $processedString');
              _logger.i('🔧 Processed string starts with {: ${processedString.startsWith('{')}');
              _logger.i('🔧 Processed string ends with }: ${processedString.endsWith('}')}');
              
              // Try to decode the JSON using the processed string
              dynamic decodedResult;
              try {
                decodedResult = jsonDecode(processedString);
                _logger.i('🔍 jsonDecode successful with processed string');
              } catch (e) {
                _logger.e('❌ jsonDecode failed with processed string: $e');
                // If JSON decode fails, treat as plain URL string
                return {
                  'streams': [
                    {'url': processedString, 'headers': {}}
                  ],
                  'subtitles': [],
                };
              }
              
              _logger.i('🔍 Decoded result: $decodedResult');
              _logger.i('🔍 Decoded result type: ${decodedResult.runtimeType}');
              
              // Check if the result is already a properly structured stream response
              if (decodedResult is Map<String, dynamic>) {
                // If it already has streams array, return it directly
                if (decodedResult.containsKey('streams') && decodedResult['streams'] is List) {
                  _logger.i('✅ Returning already structured stream data with ${(decodedResult['streams'] as List).length} streams');
                  return decodedResult;
                }
                // If it has 'url' field directly, it might be a single stream - wrap it
                else if (decodedResult.containsKey('url')) {
                  _logger.i('🔧 Wrapping single stream URL: ${decodedResult['url']}');
                  return {
                    'streams': [
                      {
                        'url': decodedResult['url'],
                        'headers': decodedResult['headers'] ?? {},
                      }
                    ],
                    'subtitles': List<String>.from(decodedResult['subtitles'] ?? []),
                  };
                }
                // Otherwise, treat the whole object as metadata and look for URL
                else {
                  _logger.w('⚠️ Unexpected Map structure in stream results: $decodedResult');
                  return decodedResult;
                }
              } else if (decodedResult is String) {
                // If it's just a URL string, wrap it
                _logger.i('🔧 Wrapping decoded URL string: $decodedResult');
                return {
                  'streams': [
                    {'url': decodedResult, 'headers': {}}
                  ],
                  'subtitles': [],
                };
              } else {
                _logger.w('⚠️ Unknown decoded results format: $decodedResult (${decodedResult.runtimeType})');
                return {
                  'streams': [],
                  'subtitles': [],
                };
              }
            } catch (e) {
              _logger.e('❌ Failed to parse stream results: $e');
              throw Exception('Failed to parse stream results: $e');
            }
          }
          break;
        }
      }
      
      throw Exception('Stream URL extraction timeout');
    } catch (e) {
      _logger.e('💥 Stream URL extraction failed: $e');
      throw Exception('Stream URL extraction failed: $e');
    }
  }
}