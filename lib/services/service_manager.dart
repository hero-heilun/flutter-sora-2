import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import '../data/models/service_metadata.dart';
import '../data/models/search_result.dart';
import 'http_service.dart';
import 'javascript_service.dart';

class Service {
  final String id;
  final ServiceMetadata metadata;
  final String localPath;
  final String metadataUrl;
  bool isActive;

  Service({
    required this.id,
    required this.metadata,
    required this.localPath,
    required this.metadataUrl,
    this.isActive = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'metadata': metadata.toJson(),
    'localPath': localPath,
    'metadataUrl': metadataUrl,
    'isActive': isActive,
  };

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json['id'],
    metadata: ServiceMetadata.fromJson(json['metadata']),
    localPath: json['localPath'],
    metadataUrl: json['metadataUrl'],
    isActive: json['isActive'] ?? false,
  );
}

class ServiceManager {
  static ServiceManager? _instance;
  static ServiceManager get instance {
    _instance ??= ServiceManager._internal();
    return _instance!;
  }

  ServiceManager._internal();

  final List<Service> _services = [];
  final Logger _logger = Logger();
  Service? _activeService; // Keep for backward compatibility, but now represents "primary" service
  late Directory _servicesDirectory;

  List<Service> get services => List.unmodifiable(_services);
  Service? get activeService => _activeService;
  
  // Get all activated services
  List<Service> get activeServices => _services.where((s) => s.isActive).toList();
  
  // Get all installed and ready services
  List<Service> get availableServices => _services.toList();

  Future<void> initialize() async {
    await _initializeDirectories();
    await _loadServicesFromStorage();
    _logger.i('Service manager initialized with ${_services.length} services');
  }

  Future<void> _initializeDirectories() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    _servicesDirectory = Directory('${documentsDir.path}/Services');
    
    if (!await _servicesDirectory.exists()) {
      await _servicesDirectory.create(recursive: true);
      _logger.i('Created Services directory: ${_servicesDirectory.path}');
    }
  }

  Future<void> addService(String metadataUrl) async {
    try {
      // Fetch metadata
      final metadata = await HttpService.instance.fetchServiceMetadata(metadataUrl);
      
      // Check if service already exists
      final existingService = _services.any((service) =>
          service.metadata.sourceName == metadata.sourceName &&
          service.metadata.author.name == metadata.author.name &&
          service.metadata.version == metadata.version);
      
      if (existingService) {
        throw Exception('Service ${metadata.sourceName} already exists');
      }
      
      // Fetch JavaScript code
      final jsContent = await HttpService.instance.fetchServiceScript(metadata.scriptUrl);
      
      // Generate unique service folder name
      final serviceId = DateTime.now().millisecondsSinceEpoch.toString();
      final serviceFolderName = '${metadata.sourceName.replaceAll(' ', '_')}_${serviceId.substring(serviceId.length - 8)}';
      final serviceDir = Directory('${_servicesDirectory.path}/$serviceFolderName');
      
      // Create service directory
      await serviceDir.create(recursive: true);
      
      // Save metadata.json
      final metadataFile = File('${serviceDir.path}/metadata.json');
      await metadataFile.writeAsString(json.encode(metadata.toJson()));
      
      // Save script.js
      final scriptFile = File('${serviceDir.path}/script.js');
      await scriptFile.writeAsString(jsContent);
      
      // Create service
      final service = Service(
        id: serviceId,
        metadata: metadata,
        localPath: serviceFolderName,
        metadataUrl: metadataUrl,
      );

      _services.add(service);
      
      // If this is the first service, make it active automatically
      if (_services.length == 1) {
        await setActiveService(service.id);
      }
      
      await _saveServicesToStorage();
      _logger.i('Added service: ${metadata.sourceName} to ${serviceDir.path}');
    } catch (e) {
      _logger.e('Failed to add service: $e');
      rethrow;
    }
  }

  Future<void> setActiveService(String serviceId) async {
    final service = _services.firstWhere((s) => s.id == serviceId);

    // Toggle service activation
    service.isActive = !service.isActive;
    
    // If activating and no primary service exists, make this the primary
    if (service.isActive && _activeService == null) {
      _activeService = service;
      
      // Note: Legacy loadService removed - services now load scripts dynamically from URLs
    }
    
    // If deactivating the primary service, choose another active one as primary
    if (!service.isActive && _activeService?.id == serviceId) {
      try {
        final newPrimary = _services.firstWhere((s) => s.isActive && s.id != serviceId);
        await setPrimaryService(newPrimary.id);
      } catch (e) {
        // No other active services found
        _activeService = null;
      }
    }

    await _saveServicesToStorage();
    _logger.i('${service.isActive ? "Activated" : "Deactivated"} service: ${service.metadata.sourceName}');
  }
  
  // Set primary service (for main browsing/streaming)
  Future<void> setPrimaryService(String serviceId) async {
    final service = _services.firstWhere(
      (s) => s.id == serviceId,
      orElse: () => throw Exception('Service not found'),
    );
    
    // Service must be active to become primary
    if (!service.isActive) {
      service.isActive = true;
    }
    
    _activeService = service;
    
    // Note: Legacy loadService removed - services now load scripts dynamically from URLs

    await _saveServicesToStorage();
    _logger.i('Set primary service: ${service.metadata.sourceName}');
  }

  Future<void> removeService(String serviceId) async {
    final service = _services.firstWhere((s) => s.id == serviceId);
    
    // Remove local files
    final serviceDir = Directory('${_servicesDirectory.path}/${service.localPath}');
    if (await serviceDir.exists()) {
      await serviceDir.delete(recursive: true);
      _logger.i('Deleted service directory: ${serviceDir.path}');
    }
    
    _services.removeWhere((s) => s.id == serviceId);
    
    if (_activeService?.id == serviceId) {
      _activeService = null;
    }

    await _saveServicesToStorage();
    _logger.i('Removed service: ${service.metadata.sourceName}');
  }

  Future<List<SearchItem>> search(String keyword) async {
    if (_activeService == null) {
      throw Exception('No active service');
    }

    return await JavaScriptService.instance.search(keyword, _activeService!);
  }

  // Multi-service search for find episode functionality
  Future<List<SearchItem>> searchWithService(String serviceId, String keyword) async {
    final service = _services.firstWhere(
      (s) => s.id == serviceId,
      orElse: () => throw Exception('Service not found: $serviceId'),
    );

    // Use the new search method with service directly (loads script from local file)
    return await JavaScriptService.instance.search(keyword, service);
  }

  Future<List<MediaItem>> getDetails(String url) async {
    if (_activeService == null) {
      throw Exception('No active service');
    }

    final mediaItem = await JavaScriptService.instance.extractDetails(url);
    return [mediaItem]; // Wrap single item in list to match return type
  }

  Future<List<EpisodeLink>> getEpisodes(String url) async {
    if (_activeService == null) {
      throw Exception('No active service');
    }

    return await JavaScriptService.instance.extractEpisodesWithService(url, _activeService!);
  }

  Future<StreamData?> getStreamUrl(String url) async {
    if (_activeService == null) {
      throw Exception('No active service');
    }

    final streamMap = await JavaScriptService.instance.extractStreamUrlWithService(url, _activeService!);
    
    print('🔍 DEBUG SERVICE_MANAGER: Raw streamMap: $streamMap');
    print('🔍 DEBUG SERVICE_MANAGER: StreamMap type: ${streamMap.runtimeType}');
    
    // Convert Map<String, dynamic> to StreamData
    if (streamMap.isNotEmpty && streamMap['streams'] != null) {
      final streamsList = streamMap['streams'] as List;
      print('🔍 DEBUG SERVICE_MANAGER: StreamsList: $streamsList');
      final streams = streamsList.map((stream) {
        print('🔍 DEBUG SERVICE_MANAGER: Processing stream: $stream');
        return StreamSource(
          url: stream['url'] ?? '',
          headers: Map<String, String>.from(stream['headers'] ?? {}),
        );
      }).toList();
      
      print('🔍 DEBUG SERVICE_MANAGER: Created StreamData with ${streams.length} streams');
      final streamData = StreamData(
        streams: streams,
        subtitles: List<String>.from(streamMap['subtitles'] ?? []),
      );
      print('🔍 DEBUG SERVICE_MANAGER: Final StreamData: $streamData');
      return streamData;
    } else if (streamMap['url'] != null) {
      // Handle simple URL case
      return StreamData(
        streams: [StreamSource(
          url: streamMap['url'],
          headers: Map<String, String>.from(streamMap['headers'] ?? {}),
        )],
        subtitles: [],
      );
    }
    
    return null;
  }

  Future<void> _loadServicesFromStorage() async {
    try {
      _services.clear();
      
      // Load services from local directories
      if (await _servicesDirectory.exists()) {
        final serviceDirs = await _servicesDirectory.list().where((entity) => entity is Directory).cast<Directory>().toList();
        
        for (final serviceDir in serviceDirs) {
          final metadataFile = File('${serviceDir.path}/metadata.json');
          final scriptFile = File('${serviceDir.path}/script.js');
          
          // Verify both files exist
          if (await metadataFile.exists() && await scriptFile.exists()) {
            try {
              final metadataJson = await metadataFile.readAsString();
              final metadata = ServiceMetadata.fromJson(json.decode(metadataJson));
              
              final service = Service(
                id: serviceDir.path.split('/').last.split('_').last,
                metadata: metadata,
                localPath: serviceDir.path.split('/').last,
                metadataUrl: '', // Will be loaded from SharedPreferences if needed
              );
              
              _services.add(service);
            } catch (e) {
              _logger.e('Failed to load service from ${serviceDir.path}: $e');
            }
          }
        }
      }
      
      // Load service states from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final serviceStates = prefs.getString('service_states');
      
      if (serviceStates != null) {
        final Map<String, dynamic> states = json.decode(serviceStates);
        
        for (final service in _services) {
          final isActive = states[service.id] ?? false;
          service.isActive = isActive;
          
          if (isActive) {
            _activeService = service;
          }
        }
      }
      
      _logger.i('Loaded ${_services.length} services from local storage');
    } catch (e) {
      _logger.e('Failed to load services from storage: $e');
    }
  }

  Future<void> _saveServicesToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Save service states to SharedPreferences
      final Map<String, bool> serviceStates = {};
      for (final service in _services) {
        serviceStates[service.id] = service.isActive;
      }
      
      await prefs.setString('service_states', json.encode(serviceStates));
      _logger.i('Saved service states to SharedPreferences');
    } catch (e) {
      _logger.e('Failed to save services to storage: $e');
    }
  }
}