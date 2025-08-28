import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/tmdb_models.dart';
import '../../services/tmdb_service.dart';

// TMDB state
final tmdbProvider = StateNotifierProvider<TMDBNotifier, TMDBState>((ref) {
  return TMDBNotifier();
});

class TMDBState {
  final List<TMDBMovie> trendingMovies;
  final List<TMDBMovie> popularMovies;
  final List<TMDBMovie> topRatedMovies;
  final List<TMDBMovie> nowPlayingMovies;
  final List<TMDBTVShow> popularTVShows;
  final List<TMDBTVShow> topRatedTVShows;
  final List<TMDBTVShow> trendingTVShows;
  final List<TMDBTVShow> popularAnime;
  final List<TMDBTVShow> topRatedAnime;
  final bool isLoading;
  final String? errorMessage;

  const TMDBState({
    this.trendingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.nowPlayingMovies = const [],
    this.popularTVShows = const [],
    this.topRatedTVShows = const [],
    this.trendingTVShows = const [],
    this.popularAnime = const [],
    this.topRatedAnime = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  TMDBState copyWith({
    List<TMDBMovie>? trendingMovies,
    List<TMDBMovie>? popularMovies,
    List<TMDBMovie>? topRatedMovies,
    List<TMDBMovie>? nowPlayingMovies,
    List<TMDBTVShow>? popularTVShows,
    List<TMDBTVShow>? topRatedTVShows,
    List<TMDBTVShow>? trendingTVShows,
    List<TMDBTVShow>? popularAnime,
    List<TMDBTVShow>? topRatedAnime,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TMDBState(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularTVShows: popularTVShows ?? this.popularTVShows,
      topRatedTVShows: topRatedTVShows ?? this.topRatedTVShows,
      trendingTVShows: trendingTVShows ?? this.trendingTVShows,
      popularAnime: popularAnime ?? this.popularAnime,
      topRatedAnime: topRatedAnime ?? this.topRatedAnime,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class TMDBNotifier extends StateNotifier<TMDBState> {
  TMDBNotifier() : super(const TMDBState()) {
    // Initialize TMDB service asynchronously
    _initializeService();
  }
  
  Future<void> _initializeService() async {
    await TMDBService.instance.initialize();
  }

  Future<void> loadHomeContent() async {
    if (state.isLoading) return;

    print('🎬 Starting to load TMDB home content...');
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      print('🎬 Making parallel API calls to TMDB...');
      // Load all home content in parallel
      final results = await Future.wait([
        TMDBService.instance.getTrendingMovies(),
        TMDBService.instance.getPopularMovies(),
        TMDBService.instance.getTopRatedMovies(),
        TMDBService.instance.getNowPlayingMovies(),
        TMDBService.instance.getPopularTVShows(),
        TMDBService.instance.getTopRatedTVShows(),
        TMDBService.instance.getTrendingTVShows(),
        TMDBService.instance.getPopularAnime(),
        TMDBService.instance.getTopRatedAnime(),
      ]);

      print('🎬 API calls completed. Results count:');
      print('  - Trending Movies: ${(results[0] as List<TMDBMovie>).length}');
      print('  - Popular Movies: ${(results[1] as List<TMDBMovie>).length}');
      print('  - Top Rated Movies: ${(results[2] as List<TMDBMovie>).length}');
      print('  - Now Playing Movies: ${(results[3] as List<TMDBMovie>).length}');
      print('  - Popular TV Shows: ${(results[4] as List<TMDBTVShow>).length}');
      print('  - Top Rated TV Shows: ${(results[5] as List<TMDBTVShow>).length}');
      print('  - Trending TV Shows: ${(results[6] as List<TMDBTVShow>).length}');
      print('  - Popular Anime: ${(results[7] as List<TMDBTVShow>).length}');
      print('  - Top Rated Anime: ${(results[8] as List<TMDBTVShow>).length}');

      final trendingMovies = results[0] as List<TMDBMovie>;
      
      state = state.copyWith(
        trendingMovies: trendingMovies,
        popularMovies: results[1] as List<TMDBMovie>,
        topRatedMovies: results[2] as List<TMDBMovie>,
        nowPlayingMovies: results[3] as List<TMDBMovie>,
        popularTVShows: results[4] as List<TMDBTVShow>,
        topRatedTVShows: results[5] as List<TMDBTVShow>,
        trendingTVShows: results[6] as List<TMDBTVShow>,
        popularAnime: results[7] as List<TMDBTVShow>,
        topRatedAnime: results[8] as List<TMDBTVShow>,
        isLoading: false,
      );
      
      print('🎬 Home content loaded successfully!');
    } catch (e, stackTrace) {
      print('❌ Failed to load TMDB content: $e');
      print('❌ Stack trace: $stackTrace');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load content: $e',
      );
    }
  }

  Future<List<TMDBMovie>> searchMovies(String query) async {
    try {
      return await TMDBService.instance.searchMovies(query);
    } catch (e) {
      return [];
    }
  }

  Future<List<TMDBTVShow>> searchTVShows(String query) async {
    try {
      return await TMDBService.instance.searchTVShows(query);
    } catch (e) {
      return [];
    }
  }

  Future<List<TMDBPerson>> searchPeople(String query) async {
    try {
      return await TMDBService.instance.searchPeople(query);
    } catch (e) {
      return [];
    }
  }

  void setLanguage(String languageCode) {
    TMDBService.instance.setLanguage(languageCode);
    // Reload content with new language
    loadHomeContent();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}