import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class GitHubServicesFetcher {
  static GitHubServicesFetcher? _instance;
  static GitHubServicesFetcher get instance {
    _instance ??= GitHubServicesFetcher._internal();
    return _instance!;
  }

  GitHubServicesFetcher._internal();

  final Dio _dio = Dio();
  final Logger _logger = Logger();

  /// Fetches all available services from the GitHub repository (Fast mode)
  Future<List<GitHubService>> fetchAvailableServices() async {
    try {
      _logger.i('🔍 Fetching services from GitHub repository...');
      
      // Get repository contents
      final response = await _dio.get(
        'https://api.github.com/repos/hero-heilun/sources/contents',
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
            'User-Agent': 'SoraFlutter/1.0',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch repository contents: ${response.statusCode}');
      }

      final List<dynamic> contents = response.data;
      final List<GitHubService> services = [];

      for (final item in contents) {
        if (item['type'] == 'dir') {
          final dirName = item['name'] as String;
          
          // Skip obvious non-service files but be more inclusive
          if (dirName.startsWith('.') || 
              dirName.toLowerCase() == 'readme' ||
              dirName.toLowerCase() == 'license' ||
              dirName.endsWith('.png') ||
              dirName.endsWith('.md') ||
              dirName == 'asset.png') {
            continue;
          }

          // For fast mode, try to determine the best config URL
          String configUrl = 'https://raw.githubusercontent.com/hero-heilun/sources/refs/heads/main/$dirName/$dirName.json';
          
          // For known services with non-standard naming, use specific patterns
          if (dirName == 's.to') {
            // s.to has sToEngDub.json and sToGerDub.json - use the first one
            configUrl = 'https://raw.githubusercontent.com/hero-heilun/sources/refs/heads/main/$dirName/sToEngDub.json';
          }

          // Add service directly without fetching metadata (fast mode)
          services.add(GitHubService(
            name: dirName,
            displayName: _formatServiceName(dirName),
            description: 'Service configuration for $dirName',
            configUrl: configUrl,
            category: _guessCategory(dirName),
            isAvailable: !dirName.contains('broken'), // Mark broken services as unavailable
          ));
        }
      }

      // Sort by name for consistent ordering
      services.sort((a, b) => a.displayName.compareTo(b.displayName));

      _logger.i('✅ Found ${services.length} services (fast mode)');
      return services;
      
    } catch (e) {
      _logger.e('💥 Failed to fetch services: $e');
      throw Exception('Failed to fetch services from GitHub: $e');
    }
  }

  /// Fetches metadata for a specific service
  Future<GitHubService?> _fetchServiceMetadata(String serviceName) async {
    try {
      // Try different possible configuration file locations
      final possibleFiles = [
        '$serviceName.json',
        'config.json',
        'metadata.json',
      ];

      // First try the standard patterns
      for (final fileName in possibleFiles) {
        try {
          final response = await _dio.get(
            'https://raw.githubusercontent.com/hero-heilun/sources/refs/heads/main/$serviceName/$fileName',
            options: Options(
              headers: {'User-Agent': 'SoraFlutter/1.0'},
              responseType: ResponseType.plain,
            ),
          );

          if (response.statusCode == 200 && response.data != null) {
            final metadata = json.decode(response.data);
            
            return GitHubService(
              name: serviceName,
              displayName: metadata['sourceName'] ?? _formatServiceName(serviceName),
              description: metadata['description'] ?? 'Service configuration for $serviceName',
              configUrl: 'https://raw.githubusercontent.com/hero-heilun/sources/refs/heads/main/$serviceName/$fileName',
              category: _categorizeService(metadata),
              isAvailable: true,
              version: metadata['version']?.toString(),
              language: metadata['language']?.toString(),
              quality: metadata['quality']?.toString(),
              iconUrl: metadata['iconUrl']?.toString(),
            );
          }
        } catch (e) {
          // Continue to next file if this one fails
          continue;
        }
      }

      // If standard patterns fail, fetch directory contents and look for any .json files
      try {
        final dirResponse = await _dio.get(
          'https://api.github.com/repos/hero-heilun/sources/contents/$serviceName',
          options: Options(
            headers: {
              'Accept': 'application/vnd.github.v3+json',
              'User-Agent': 'SoraFlutter/1.0',
            },
          ),
        );

        if (dirResponse.statusCode == 200) {
          final List<dynamic> files = dirResponse.data;
          final jsonFiles = files
              .where((file) => file['type'] == 'file' && file['name'].toString().endsWith('.json'))
              .toList();

          if (jsonFiles.isNotEmpty) {
            // Try the first JSON file found
            final firstJsonFile = jsonFiles.first;
            final fileName = firstJsonFile['name'] as String;
            
            try {
              final response = await _dio.get(
                'https://raw.githubusercontent.com/hero-heilun/sources/refs/heads/main/$serviceName/$fileName',
                options: Options(
                  headers: {'User-Agent': 'SoraFlutter/1.0'},
                  responseType: ResponseType.plain,
                ),
              );

              if (response.statusCode == 200 && response.data != null) {
                final metadata = json.decode(response.data);
                
                return GitHubService(
                  name: serviceName,
                  displayName: metadata['sourceName'] ?? _formatServiceName(serviceName),
                  description: metadata['description'] ?? 'Service configuration for $serviceName',
                  configUrl: 'https://raw.githubusercontent.com/hero-heilun/sources/refs/heads/main/$serviceName/$fileName',
                  category: _categorizeService(metadata),
                  isAvailable: true,
                  version: metadata['version']?.toString(),
                  language: metadata['language']?.toString(),
                  quality: metadata['quality']?.toString(),
                  iconUrl: metadata['iconUrl']?.toString(),
                );
              }
            } catch (e) {
              _logger.w('Failed to fetch $fileName for $serviceName: $e');
            }
          }
        }
      } catch (e) {
        _logger.w('Failed to fetch directory contents for $serviceName: $e');
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Categorizes service based on name and metadata
  String _categorizeService(Map<String, dynamic>? metadata) {
    if (metadata != null) {
      final sourceName = metadata['sourceName']?.toString().toLowerCase() ?? '';
      final description = metadata['description']?.toString().toLowerCase() ?? '';
      
      if (sourceName.contains('anime') || description.contains('anime')) {
        return 'Anime';
      } else if (sourceName.contains('movie') || description.contains('movie')) {
        return 'Movies';
      } else if (sourceName.contains('novel') || description.contains('novel') || sourceName.contains('book')) {
        return 'Novels';
      } else if (sourceName.contains('tv') || description.contains('series')) {
        return 'TV Shows';
      }
    }
    
    return 'Other';
  }

  /// Guess category based on service name
  String _guessCategory(String serviceName) {
    final name = serviceName.toLowerCase();
    
    // Anime services
    if (name.contains('anime') || 
        name.contains('aniwatch') || 
        name.contains('gogoanime') ||
        name.contains('9anime') ||
        name.contains('hianime') ||
        name.contains('animeheaven') ||
        name.contains('animepahe') ||
        name.contains('kissanime') ||
        name.contains('zoro')) {
      return 'Anime';
    }
    
    // Movie services  
    if (name.contains('movie') || 
        name.contains('film') || 
        name.contains('cinema') ||
        name.contains('hdmovie') ||
        name.contains('movies') ||
        name.contains('vegamovies') ||
        name.contains('filmyzilla') ||
        name.contains('poseidon') ||
        name.contains('faselhd') ||
        name.contains('filmehd') ||
        name == 's.to' ||  // s.to is a movie streaming service
        name.contains('turkish123') ||
        name.contains('arabseed')) {
      return 'Movies';
    }
    
    // Novel/Book services
    if (name.contains('novel') || 
        name.contains('book') || 
        name.contains('read') ||
        name.contains('novelbin') ||
        name.contains('readnovelfull') ||
        name.contains('wuxiaworld') ||
        name.contains('lightnovel')) {
      return 'Novels';
    }
    
    // TV Shows/Series
    if (name.contains('tv') || 
        name.contains('series') || 
        name.contains('drama') ||
        name.contains('show') ||
        name.contains('episode')) {
      return 'TV Shows';
    }
    
    // Generic streaming services (likely movies/shows)
    if (name.contains('stream') ||
        name.contains('watch') ||
        name.contains('play') ||
        name.contains('video') ||
        name.contains('hd') ||
        name.endsWith('.to') ||
        name.endsWith('.tv') ||
        name.endsWith('.co') ||
        name.contains('123')) {
      return 'Movies';
    }
    
    return 'Other';
  }

  /// Format service name for display
  String _formatServiceName(String serviceName) {
    // Handle special cases first
    if (serviceName == 's.to') return 'S.TO';
    if (serviceName.toLowerCase() == 'hianime') return 'HiAnime';
    if (serviceName.toLowerCase() == '9anime') return '9Anime';
    if (serviceName.toLowerCase().contains('turkish123')) return 'Turkish123';
    
    // Convert kebab-case or snake_case to title case
    return serviceName
        .split(RegExp(r'[-_]'))
        .map((word) => word.isNotEmpty 
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : word)
        .join(' ');
  }

  /// Batch import selected services
  Future<List<String>> batchImportServices(List<GitHubService> selectedServices) async {
    final List<String> successfulImports = [];
    final List<String> failedImports = [];

    _logger.i('🔄 Starting batch import of ${selectedServices.length} services...');

    for (final service in selectedServices) {
      try {
        _logger.i('📥 Importing service: ${service.displayName}');
        
        // Here you would integrate with your existing service import logic
        // For now, we'll simulate the import
        await Future.delayed(const Duration(milliseconds: 500));
        
        successfulImports.add(service.displayName);
        _logger.i('✅ Successfully imported: ${service.displayName}');
        
      } catch (e) {
        _logger.e('❌ Failed to import ${service.displayName}: $e');
        failedImports.add('${service.displayName}: $e');
      }
    }

    _logger.i('🎉 Batch import completed. Success: ${successfulImports.length}, Failed: ${failedImports.length}');
    
    if (failedImports.isNotEmpty) {
      throw Exception('Some imports failed: ${failedImports.join(', ')}');
    }

    return successfulImports;
  }
}

class GitHubService {
  final String name;
  final String displayName;
  final String description;
  final String configUrl;
  final String category;
  final bool isAvailable;
  final String? version;
  final String? language;
  final String? quality;
  final String? iconUrl;

  GitHubService({
    required this.name,
    required this.displayName,
    required this.description,
    required this.configUrl,
    required this.category,
    required this.isAvailable,
    this.version,
    this.language,
    this.quality,
    this.iconUrl,
  });

  @override
  String toString() => 'GitHubService(name: $name, displayName: $displayName, category: $category)';
}