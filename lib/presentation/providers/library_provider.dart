import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../data/models/library_models.dart';
import '../../data/models/tmdb_models.dart';

// Library state providers
final libraryProvider = StateNotifierProvider<LibraryNotifier, LibraryState>((ref) {
  return LibraryNotifier();
});

class LibraryState {
  final List<FavoriteItem> favorites;
  final List<WatchHistoryItem> watchHistory;
  final List<Bookmark> bookmarks;
  final bool isLoading;
  final String? errorMessage;

  const LibraryState({
    this.favorites = const [],
    this.watchHistory = const [],
    this.bookmarks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  LibraryState copyWith({
    List<FavoriteItem>? favorites,
    List<WatchHistoryItem>? watchHistory,
    List<Bookmark>? bookmarks,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LibraryState(
      favorites: favorites ?? this.favorites,
      watchHistory: watchHistory ?? this.watchHistory,
      bookmarks: bookmarks ?? this.bookmarks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class LibraryNotifier extends StateNotifier<LibraryState> {
  static const String _favoritesKey = 'favorites';
  static const String _watchHistoryKey = 'watch_history';
  static const String _bookmarksKey = 'bookmarks';
  
  SharedPreferences? _prefs;

  LibraryNotifier() : super(const LibraryState()) {
    _initializeLibrary();
  }

  Future<void> _initializeLibrary() async {
    state = state.copyWith(isLoading: true);
    
    try {
      _prefs = await SharedPreferences.getInstance();
      await _loadLibraryData();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to initialize library: $e',
      );
    }
  }

  Future<void> _loadLibraryData() async {
    // Load favorites
    final favoritesJson = _prefs?.getString(_favoritesKey);
    if (favoritesJson != null && favoritesJson.isNotEmpty) {
      try {
        final favoritesList = (json.decode(favoritesJson) as List)
            .map((item) => FavoriteItem.fromJson(item as Map<String, dynamic>))
            .toList();
        state = state.copyWith(favorites: favoritesList);
      } catch (e) {
        // Handle parsing error
      }
    }

    // Load watch history
    final historyJson = _prefs?.getString(_watchHistoryKey);
    if (historyJson != null && historyJson.isNotEmpty) {
      try {
        final historyList = (json.decode(historyJson) as List)
            .map((item) => WatchHistoryItem.fromJson(item as Map<String, dynamic>))
            .toList();
        state = state.copyWith(watchHistory: historyList);
      } catch (e) {
        // Handle parsing error
      }
    }

    // Load bookmarks
    final bookmarksJson = _prefs?.getString(_bookmarksKey);
    if (bookmarksJson != null && bookmarksJson.isNotEmpty) {
      try {
        final bookmarksList = (json.decode(bookmarksJson) as List)
            .map((item) => Bookmark.fromJson(item as Map<String, dynamic>))
            .toList();
        state = state.copyWith(bookmarks: bookmarksList);
      } catch (e) {
        // Handle parsing error
      }
    }
  }

  // Favorites management
  Future<void> addToFavorites(FavoriteItem item) async {
    final favorites = [...state.favorites];
    
    // Remove if already exists (to avoid duplicates)
    favorites.removeWhere((fav) => fav.id == item.id && fav.type == item.type);
    
    // Add new item at the beginning
    favorites.insert(0, item);
    
    state = state.copyWith(favorites: favorites);
    await _saveFavorites();
  }

  Future<void> removeFromFavorites(String id, String type) async {
    final favorites = state.favorites
        .where((item) => !(item.id == id && item.type == type))
        .toList();
    
    state = state.copyWith(favorites: favorites);
    await _saveFavorites();
  }

  bool isFavorite(String id, String type) {
    return state.favorites.any((item) => item.id == id && item.type == type);
  }

  // Convenience methods for TMDB items
  Future<void> toggleMovieFavorite(TMDBMovie movie) async {
    final favoriteItem = FavoriteItem.fromTMDBMovie(movie);
    
    if (isFavorite(movie.id.toString(), 'movie')) {
      await removeFromFavorites(movie.id.toString(), 'movie');
    } else {
      await addToFavorites(favoriteItem);
    }
  }

  Future<void> toggleTVShowFavorite(TMDBTVShow tvShow) async {
    final favoriteItem = FavoriteItem.fromTMDBTVShow(tvShow);
    
    if (isFavorite(tvShow.id.toString(), 'tv')) {
      await removeFromFavorites(tvShow.id.toString(), 'tv');
    } else {
      await addToFavorites(favoriteItem);
    }
  }

  // Convenience methods for TMDB detail items
  Future<void> toggleMovieDetailFavorite(TMDBMovieDetail movieDetail) async {
    final favoriteItem = FavoriteItem.fromTMDBMovieDetail(movieDetail);
    
    if (isFavorite(movieDetail.id.toString(), 'movie')) {
      await removeFromFavorites(movieDetail.id.toString(), 'movie');
    } else {
      await addToFavorites(favoriteItem);
    }
  }

  Future<void> toggleTVShowDetailFavorite(TMDBTVShowDetail tvShowDetail) async {
    final favoriteItem = FavoriteItem.fromTMDBTVShowDetail(tvShowDetail);
    
    if (isFavorite(tvShowDetail.id.toString(), 'tv')) {
      await removeFromFavorites(tvShowDetail.id.toString(), 'tv');
    } else {
      await addToFavorites(favoriteItem);
    }
  }

  // Watch history management
  Future<void> addToWatchHistory(WatchHistoryItem item) async {
    final history = [...state.watchHistory];
    
    // Remove existing entry for the same item
    history.removeWhere((h) => h.id == item.id && h.type == item.type);
    
    // Add new entry at the beginning
    history.insert(0, item);
    
    // Keep only the latest 100 items
    if (history.length > 100) {
      history.removeRange(100, history.length);
    }
    
    state = state.copyWith(watchHistory: history);
    await _saveWatchHistory();
  }

  Future<void> clearWatchHistory() async {
    state = state.copyWith(watchHistory: []);
    await _saveWatchHistory();
  }

  // Bookmarks management
  Future<void> addBookmark(Bookmark bookmark) async {
    final bookmarks = [...state.bookmarks, bookmark];
    state = state.copyWith(bookmarks: bookmarks);
    await _saveBookmarks();
  }

  Future<void> removeBookmark(String id) async {
    final bookmarks = state.bookmarks.where((b) => b.id != id).toList();
    state = state.copyWith(bookmarks: bookmarks);
    await _saveBookmarks();
  }

  // Save methods
  Future<void> _saveFavorites() async {
    _prefs ??= await SharedPreferences.getInstance();
    final favoritesJson = json.encode(
      state.favorites.map((item) => item.toJson()).toList(),
    );
    await _prefs!.setString(_favoritesKey, favoritesJson);
  }

  Future<void> _saveWatchHistory() async {
    _prefs ??= await SharedPreferences.getInstance();
    final historyJson = json.encode(
      state.watchHistory.map((item) => item.toJson()).toList(),
    );
    await _prefs!.setString(_watchHistoryKey, historyJson);
  }

  Future<void> _saveBookmarks() async {
    _prefs ??= await SharedPreferences.getInstance();
    final bookmarksJson = json.encode(
      state.bookmarks.map((item) => item.toJson()).toList(),
    );
    await _prefs!.setString(_bookmarksKey, bookmarksJson);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}