import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/tmdb_models.dart';

class TMDBService {
  static TMDBService? _instance;
  static TMDBService get instance {
    _instance ??= TMDBService._internal();
    return _instance!;
  }

  TMDBService._internal();

  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '738b4edd0a156cc126dc4a4b8aea4aca'; // From original Sora project
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/';
  
  late Dio _dio;
  final Logger _logger = Logger();
  bool _isInitialized = false;
  
  String _language = 'en-US';

  Future<void> initialize({String? language}) async {
    if (_isInitialized) return;

    // Check if API key is configured
    if (_apiKey.isEmpty || _apiKey == 'YOUR_TMDB_API_KEY_HERE') {
      _logger.e('TMDB API key not configured. Please set a valid API key.');
      throw Exception('TMDB API key not configured. Please get a key from https://www.themoviedb.org/settings/api');
    }

    // Load language from SharedPreferences if not provided
    if (language == null) {
      final prefs = await SharedPreferences.getInstance();
      language = prefs.getString('tmdb_language') ?? 'en-US';
    }
    
    _language = language;
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      queryParameters: {
        'api_key': _apiKey,
        'language': _language,
      },
      headers: {
        'User-Agent': 'Sora-Flutter/1.0',
      },
    ));

    // _dio.interceptors.add(LogInterceptor(
    //   requestBody: false,
    //   responseBody: false,
    //   requestHeader: false,
    //   responseHeader: false,
    //   request: false,
    //   logPrint: (obj) => _logger.d(obj),
    // ));

    _isInitialized = true;
    _logger.i('TMDB service initialized with language: $_language');
    
    // Load configuration
    await _loadConfiguration();
  }

  Future<void> _loadConfiguration() async {
    try {
      await _dio.get('/configuration');
      _logger.i('TMDB configuration loaded');
    } catch (e) {
      _logger.e('Failed to load TMDB configuration: $e');
    }
  }

  // Search methods
  Future<List<TMDBMovie>> searchMovies(String query, {int page = 1}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {
          'query': query,
          'page': page,
          'include_adult': false,
        },
      );
      
      final results = response.data['results'] as List;
      return results.map((json) => TMDBMovie.fromJson(json)).toList();
    } catch (e) {
      _logger.e('Movie search failed: $e');
      return [];
    }
  }

  Future<List<TMDBTVShow>> searchTVShows(String query, {int page = 1}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get(
        '/search/tv',
        queryParameters: {
          'query': query,
          'page': page,
          'include_adult': false,
        },
      );
      
      final results = response.data['results'] as List;
      return results.map((json) => TMDBTVShow.fromJson(json)).toList();
    } catch (e) {
      _logger.e('TV show search failed: $e');
      return [];
    }
  }

  Future<List<TMDBPerson>> searchPeople(String query, {int page = 1}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get(
        '/search/person',
        queryParameters: {
          'query': query,
          'page': page,
          'include_adult': false,
        },
      );
      
      final results = response.data['results'] as List;
      return results.map((json) => TMDBPerson.fromJson(json)).toList();
    } catch (e) {
      _logger.e('People search failed: $e');
      return [];
    }
  }

  // Discover methods
  Future<List<TMDBMovie>> getTrendingMovies({String timeWindow = 'week'}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get('/trending/movie/$timeWindow');
      final results = response.data['results'] as List;
      print('📊 TRENDING movies API results count: ${results.length}');
      return results.map((json) => TMDBMovie.fromJson(json)).toList();
    } catch (e) {
      _logger.e('Get trending movies failed: $e');
      return [];
    }
  }

  Future<List<TMDBTVShow>> getTrendingTVShows({String timeWindow = 'week'}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get('/trending/tv/$timeWindow');
      final results = response.data['results'] as List;
      return results.map((json) => TMDBTVShow.fromJson(json)).toList();
    } catch (e) {
      _logger.e('Get trending TV shows failed: $e');
      return [];
    }
  }

  Future<List<TMDBMovie>> getPopularMovies({int page = 1}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );
      final results = response.data['results'] as List;
      return results.map((json) => TMDBMovie.fromJson(json)).toList();
    } catch (e) {
      _logger.e('Get popular movies failed: $e');
      return [];
    }
  }

  Future<List<TMDBTVShow>> getPopularTVShows({int page = 1}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get(
        '/tv/popular',
        queryParameters: {'page': page},
      );
      final results = response.data['results'] as List;
      return results.map((json) => TMDBTVShow.fromJson(json)).toList();
    } catch (e) {
      _logger.e('Get popular TV shows failed: $e');
      return [];
    }
  }

  Future<List<TMDBMovie>> getTopRatedMovies({int page = 1}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );
      final results = response.data['results'] as List;
      print('📊 TOP RATED movies API results count: ${results.length}');
      return results.map((json) => TMDBMovie.fromJson(json)).toList();
    } catch (e) {
      _logger.e('Get top rated movies failed: $e');
      return [];
    }
  }

  Future<List<TMDBTVShow>> getTopRatedTVShows({int page = 1}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get(
        '/tv/top_rated',
        queryParameters: {'page': page},
      );
      final results = response.data['results'] as List;
      return results.map((json) => TMDBTVShow.fromJson(json)).toList();
    } catch (e) {
      _logger.e('Get top rated TV shows failed: $e');
      return [];
    }
  }

  Future<List<TMDBMovie>> getNowPlayingMovies({int page = 1}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );
      final results = response.data['results'] as List;
      return results.map((json) => TMDBMovie.fromJson(json)).toList();
    } catch (e) {
      _logger.e('Get now playing movies failed: $e');
      return [];
    }
  }

  Future<List<TMDBTVShow>> getPopularAnime({int page = 1}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      // Anime is identified by genre_id 16 (Animation) and origin_country JP
      final response = await _dio.get(
        '/discover/tv',
        queryParameters: {
          'page': page,
          'sort_by': 'popularity.desc',
          'with_genres': '16', // Animation genre
          'with_origin_country': 'JP', // Japanese origin
          'include_adult': false,
        },
      );
      final results = response.data['results'] as List;
      return results.map((json) => TMDBTVShow.fromJson(json)).toList();
    } catch (e) {
      _logger.e('Get popular anime failed: $e');
      return [];
    }
  }

  Future<List<TMDBTVShow>> getTopRatedAnime({int page = 1}) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      // Anime is identified by genre_id 16 (Animation) and origin_country JP
      final response = await _dio.get(
        '/discover/tv',
        queryParameters: {
          'page': page,
          'sort_by': 'vote_average.desc',
          'vote_count.gte': 100, // Minimum vote count for quality
          'with_genres': '16', // Animation genre
          'with_origin_country': 'JP', // Japanese origin
          'include_adult': false,
        },
      );
      final results = response.data['results'] as List;
      return results.map((json) => TMDBTVShow.fromJson(json)).toList();
    } catch (e) {
      _logger.e('Get top rated anime failed: $e');
      return [];
    }
  }

  // Get Movie Details
  Future<TMDBMovieDetail> getMovieDetails(int id) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get('/movie/$id');
      return TMDBMovieDetail.fromJson(response.data);
    } catch (e) {
      _logger.e('Get movie details failed: $e');
      throw Exception('Failed to load movie details: $e');
    }
  }

  // Get TV Show Details
  Future<TMDBTVShowDetail> getTVShowDetails(int id) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get('/tv/$id');
      return TMDBTVShowDetail.fromJson(response.data);
    } catch (e) {
      _logger.e('Get TV show details failed: $e');
      throw Exception('Failed to load TV show details: $e');
    }
  }

  // Get Season Details
  Future<TMDBSeasonDetail> getSeasonDetails(int tvShowId, int seasonNumber) async {
    if (!_isInitialized) throw Exception('TMDB service not initialized');
    
    try {
      final response = await _dio.get('/tv/$tvShowId/season/$seasonNumber');
      return TMDBSeasonDetail.fromJson(response.data);
    } catch (e) {
      _logger.e('Get season details failed: $e');
      throw Exception('Failed to load season details: $e');
    }
  }

  // Image URL helpers
  String getImageUrl(String? path, {String size = 'w500'}) {
    if (path == null || path.isEmpty) return '';
    return '$_imageBaseUrl$size$path';
  }

  String getPosterUrl(String? path, {String size = 'w342'}) {
    return getImageUrl(path, size: size);
  }

  String getBackdropUrl(String? path, {String size = 'w780'}) {
    return getImageUrl(path, size: size);
  }

  String getProfileUrl(String? path, {String size = 'w185'}) {
    return getImageUrl(path, size: size);
  }

  // Language management
  void setLanguage(String language) {
    if (_language != language) {
      _language = language;
      _dio.options.queryParameters['language'] = language;
      _logger.i('TMDB language changed to: $language');
    }
  }

  String get currentLanguage => _language;

  // Available languages (from iOS project)
  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'en-US', 'name': 'English (US)'},
    {'code': 'zh-CN', 'name': '中文 (简体)'},
    {'code': 'zh-TW', 'name': '中文 (繁體)'},
    {'code': 'ja-JP', 'name': '日本語'},
    {'code': 'ko-KR', 'name': '한국어'},
    {'code': 'fr-FR', 'name': 'Français'},
    {'code': 'de-DE', 'name': 'Deutsch'},
    {'code': 'es-ES', 'name': 'Español'},
    {'code': 'pt-BR', 'name': 'Português (Brasil)'},
    {'code': 'ru-RU', 'name': 'Русский'},
    {'code': 'it-IT', 'name': 'Italiano'},
    {'code': 'ar-SA', 'name': 'العربية'},
    {'code': 'hi-IN', 'name': 'हिन्दी'},
    {'code': 'th-TH', 'name': 'ไทย'},
    {'code': 'vi-VN', 'name': 'Tiếng Việt'},
    {'code': 'tr-TR', 'name': 'Türkçe'},
    {'code': 'nl-NL', 'name': 'Nederlands'},
    {'code': 'sv-SE', 'name': 'Svenska'},
    {'code': 'da-DK', 'name': 'Dansk'},
    {'code': 'no-NO', 'name': 'Norsk'},
    {'code': 'fi-FI', 'name': 'Suomi'},
    {'code': 'pl-PL', 'name': 'Polski'},
    {'code': 'cs-CZ', 'name': 'Čeština'},
  ];
}