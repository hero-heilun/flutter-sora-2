import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../data/models/service_metadata.dart';

class HttpService {
  static HttpService? _instance;
  static HttpService get instance {
    _instance ??= HttpService._internal();
    return _instance!;
  }

  HttpService._internal();

  late Dio _dio;
  final Logger _logger = Logger();
  bool _isInitialized = false;
  
  // Random User-Agent pool to avoid 403 errors
  static final List<String> _userAgents = [
    // Chrome
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.6998.0 Safari/537.36',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36',
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36',
    
    // Firefox
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:136.0) Gecko/20100101 Firefox/136.0',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 14.7; rv:136.0) Gecko/20100101 Firefox/136.0',
    'Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0',
    
    // Edge
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.3124.0',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.3124.0',
    
    // Safari
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 14_7_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Safari/605.1.15',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 14_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Safari/605.1.15',
  ];
  
  static final Random _random = Random();
  
  static String get _randomUserAgent {
    return _userAgents[_random.nextInt(_userAgents.length)];
  }

  void initialize() {
    if (_isInitialized) return;

    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      followRedirects: true,
      maxRedirects: 5,
      validateStatus: (status) {
        // Accept all status codes to handle them manually
        return status! < 500;
      },
      headers: {
        'User-Agent': _randomUserAgent,
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      requestBody: false,
      responseBody: false,
      logPrint: (obj) => _logger.d(obj),
    ));

    _isInitialized = true;
    _logger.i('HTTP service initialized');
  }

  // New fetchV2 method with proper parameter handling
  Future<String> dartFetchV2({
    required String url,
    required String method,
    required Map<String, dynamic> headers,
    String? body,
  }) async {
    if (!_isInitialized) initialize();

    try {
      _logger.d('FetchV2: URL=$url, Method=$method');

      if (url.isEmpty) {
        throw Exception('URL is empty');
      }

      // Prepare headers with random User-Agent for each request
      final requestHeaders = <String, String>{
        'User-Agent': _randomUserAgent,
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.5',
        'Accept-Encoding': 'gzip, deflate, br',
        'DNT': '1',
        'Connection': 'keep-alive',
        'Upgrade-Insecure-Requests': '1',
        'Sec-Fetch-Dest': 'document',
        'Sec-Fetch-Mode': 'navigate',
        'Sec-Fetch-Site': 'none',
      };
      
      // Merge with headers from JavaScript
      headers.forEach((key, value) {
        requestHeaders[key] = value.toString();
      });

      final response = await _dio.request(
        url,
        options: Options(
          method: method,
          headers: requestHeaders,
          responseType: ResponseType.plain, // Get raw string response, don't parse JSON
          validateStatus: (status) => true,
        ),
        data: body,
      );

      // Handle error responses gracefully
      if (response.statusCode == 403) {
        _logger.w('Got 403 Forbidden for URL: $url');
        return '<html><body></body></html>';
      }
      
      if (response.statusCode! >= 400) {
        _logger.w('Got error status ${response.statusCode} for URL: $url');
        return '<html><body>Error ${response.statusCode}</body></html>';
      }

      // Return the raw string response (should be valid JSON string from s.to)
      return response.data as String;
    } catch (e) {
      _logger.e('FetchV2 request failed: $e');
      return '<html><body>Network Error</body></html>';
    }
  }

  // Legacy dartFetch method for backward compatibility
  Future<String> dartFetch(String requestJson) async {
    if (!_isInitialized) initialize();

    try {
      _logger.d('Raw request data: $requestJson');
      
      Map<String, dynamic> request = _parseRequestJson(requestJson);

      final String url = request['url']?.toString() ?? '';
      final String method = request['method']?.toString() ?? 'GET';
      final Map<String, dynamic> headers = Map<String, dynamic>.from(request['headers'] ?? {});
      final String? body = request['body']?.toString();

      _logger.d('Parsed request - URL: $url, Method: $method, Headers: $headers');

      if (url.isEmpty) {
        throw Exception('URL is empty');
      }

      // Prepare headers with random User-Agent for each request
      final requestHeaders = <String, String>{
        'User-Agent': _randomUserAgent,  // Use fresh random User-Agent for each request
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.5',
        'Accept-Encoding': 'gzip, deflate, br',
        'DNT': '1',
        'Connection': 'keep-alive',
        'Upgrade-Insecure-Requests': '1',
        'Sec-Fetch-Dest': 'document',
        'Sec-Fetch-Mode': 'navigate',
        'Sec-Fetch-Site': 'none',
        'Cache-Control': 'max-age=0',
      };
      
      // Merge with headers from JavaScript (JS headers take priority)
      headers.forEach((key, value) {
        requestHeaders[key] = value.toString();
      });

      final response = await _dio.request(
        url,
        options: Options(
          method: method,
          headers: requestHeaders,
          responseType: ResponseType.plain, // Get raw string response, don't parse JSON
          validateStatus: (status) => true, // Accept all status codes
        ),
        data: body,
      );

      // Handle 403 and other error responses gracefully
      if (response.statusCode == 403) {
        _logger.w('Got 403 Forbidden for URL: $url');
        _logger.w('Returning empty HTML to avoid script error');
        // Return empty HTML that the script can parse
        return '<html><body></body></html>';
      }
      
      if (response.statusCode! >= 400) {
        _logger.w('Got error status ${response.statusCode} for URL: $url');
        return '<html><body>Error ${response.statusCode}</body></html>';
      }

      return response.data.toString();
    } catch (e) {
      _logger.e('HTTP request failed: $e');
      // Return empty response instead of throwing to avoid breaking the script
      return '<html><body>Network Error</body></html>';
    }
  }

  Future<ServiceMetadata> fetchServiceMetadata(String url) async {
    if (!_isInitialized) initialize();

    try {
      final response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain, // Get plain text response
        ),
      );
      
      // Parse the JSON string manually
      final jsonData = json.decode(response.data);
      return ServiceMetadata.fromJson(jsonData);
    } catch (e) {
      _logger.e('Failed to fetch service metadata: $e');
      rethrow;
    }
  }

  Future<String> fetchServiceScript(String url) async {
    if (!_isInitialized) initialize();

    try {
      final response = await _dio.get(url);
      return response.data.toString();
    } catch (e) {
      _logger.e('Failed to fetch service script: $e');
      rethrow;
    }
  }

  Map<String, dynamic> _parseRequestJson(String requestJson) {
    try {
      // First, ensure we have a clean string to parse
      String cleanString = requestJson.trim();
      
      // Remove outer quotes if they exist (flutter_js adds them)
      if (cleanString.startsWith('"') && cleanString.endsWith('"')) {
        cleanString = cleanString.substring(1, cleanString.length - 1);
        // Unescape any escaped quotes and backslashes
        cleanString = cleanString.replaceAll('\\\\', '\\');
        cleanString = cleanString.replaceAll('\\"', '"');
      }
      
      // Check if it looks like a valid JSON object
      if (!cleanString.startsWith('{')) {
        _logger.w('Request data does not look like JSON, attempting manual parsing');
        throw FormatException('Not a JSON object');
      }
      
      // Try to parse the cleaned JSON
      return json.decode(cleanString);
    } catch (e) {
      _logger.e('JSON decode failed, trying alternative parsing: $e');
      
      // If JSON parsing fails, try to extract values manually
      try {
        String cleanString = requestJson.trim();
        
        // Simple extraction using string operations
        String url = '';
        String method = 'GET';
        
        // Extract URL
        int urlIndex = cleanString.indexOf('url');
        if (urlIndex >= 0) {
          int colonIndex = cleanString.indexOf(':', urlIndex);
          if (colonIndex > 0) {
            int endIndex = cleanString.indexOf(',', colonIndex);
            if (endIndex < 0) endIndex = cleanString.indexOf('}', colonIndex);
            if (endIndex > colonIndex) {
              url = cleanString.substring(colonIndex + 1, endIndex).trim();
              // Remove quotes if present
              url = url.replaceAll('"', '').replaceAll("'", '').trim();
            }
          }
        }
        
        // Extract method
        int methodIndex = cleanString.indexOf('method');
        if (methodIndex >= 0) {
          int colonIndex = cleanString.indexOf(':', methodIndex);
          if (colonIndex > 0) {
            int endIndex = cleanString.indexOf(',', colonIndex);
            if (endIndex < 0) endIndex = cleanString.indexOf('}', colonIndex);
            if (endIndex > colonIndex) {
              method = cleanString.substring(colonIndex + 1, endIndex).trim();
              // Remove quotes if present
              method = method.replaceAll('"', '').replaceAll("'", '').trim();
            }
          }
        }
        
        if (url.isNotEmpty) {
          
          return {
            'url': url,
            'method': method,
            'headers': <String, dynamic>{},
            'body': null,
          };
        }
      } catch (regexError) {
        _logger.e('Regex parsing also failed: $regexError');
      }
      
      throw Exception('Could not parse request data: $requestJson');
    }
  }
}