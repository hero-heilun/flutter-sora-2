import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/tmdb_service.dart';
import '../pages/category_list_page.dart';

// State for paginated category content
class CategoryState {
  final List<dynamic> items; // Can be List<TMDBMovie> or List<TMDBTVShow>
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int currentPage;
  final String? errorMessage;

  const CategoryState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.currentPage = 1,
    this.errorMessage,
  });

  CategoryState copyWith({
    List<dynamic>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? currentPage,
    String? errorMessage,
  }) {
    return CategoryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage,
    );
  }
}

// Provider factory for category content
final categoryProvider = StateNotifierProvider.family<CategoryNotifier, CategoryState, CategoryType>((ref, categoryType) {
  return CategoryNotifier(categoryType);
});

class CategoryNotifier extends StateNotifier<CategoryState> {
  final CategoryType categoryType;

  CategoryNotifier(this.categoryType) : super(const CategoryState()) {
    loadInitialContent();
  }

  Future<void> loadInitialContent() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final items = await _loadPage(1);
      state = state.copyWith(
        items: items,
        isLoading: false,
        hasMore: items.isNotEmpty && items.length >= 20, // TMDB usually returns 20 items per page
        currentPage: 1,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load content: $e',
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final newItems = await _loadPage(nextPage);
      
      if (newItems.isEmpty) {
        state = state.copyWith(
          isLoadingMore: false,
          hasMore: false,
        );
      } else {
        final allItems = [...state.items, ...newItems];
        state = state.copyWith(
          items: allItems,
          isLoadingMore: false,
          currentPage: nextPage,
          hasMore: newItems.length >= 20,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: 'Failed to load more content: $e',
      );
    }
  }

  Future<void> refresh() async {
    state = const CategoryState();
    await loadInitialContent();
  }

  Future<List<dynamic>> _loadPage(int page) async {
    switch (categoryType) {
      case CategoryType.trendingMovies:
        return await TMDBService.instance.getCategoryMovies('trending', page: page);
      case CategoryType.popularMovies:
        return await TMDBService.instance.getCategoryMovies('popular', page: page);
      case CategoryType.topRatedMovies:
        return await TMDBService.instance.getCategoryMovies('top_rated', page: page);
      case CategoryType.nowPlayingMovies:
        return await TMDBService.instance.getCategoryMovies('now_playing', page: page);
      case CategoryType.popularTVShows:
        return await TMDBService.instance.getCategoryTVShows('popular', page: page);
      case CategoryType.topRatedTVShows:
        return await TMDBService.instance.getCategoryTVShows('top_rated', page: page);
      case CategoryType.popularAnime:
        return await TMDBService.instance.getCategoryTVShows('popular_anime', page: page);
      case CategoryType.topRatedAnime:
        return await TMDBService.instance.getCategoryTVShows('top_rated_anime', page: page);
    }
  }
}