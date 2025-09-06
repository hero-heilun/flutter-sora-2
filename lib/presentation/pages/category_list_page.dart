import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/category_provider.dart';
import '../../data/models/tmdb_models.dart';
import '../../services/tmdb_service.dart';

enum CategoryType {
  trendingMovies,
  popularMovies,
  topRatedMovies,
  nowPlayingMovies,
  popularTVShows,
  topRatedTVShows,
  popularAnime,
  topRatedAnime,
}

extension CategoryTypeExtension on CategoryType {
  String get title {
    switch (this) {
      case CategoryType.trendingMovies:
        return 'Trending Movies';
      case CategoryType.popularMovies:
        return 'Popular Movies';
      case CategoryType.topRatedMovies:
        return 'Top Rated Movies';
      case CategoryType.nowPlayingMovies:
        return 'Now Playing';
      case CategoryType.popularTVShows:
        return 'Popular TV Shows';
      case CategoryType.topRatedTVShows:
        return 'Top Rated TV Shows';
      case CategoryType.popularAnime:
        return 'Popular Anime';
      case CategoryType.topRatedAnime:
        return 'Top Rated Anime';
    }
  }
}

class CategoryListPage extends ConsumerStatefulWidget {
  final CategoryType categoryType;

  const CategoryListPage({
    super.key,
    required this.categoryType,
  });

  @override
  ConsumerState<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends ConsumerState<CategoryListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      // Load more when user is 300 pixels away from bottom
      ref.read(categoryProvider(widget.categoryType).notifier).loadMore();
    }
  }

  bool _isMovieCategory(CategoryType categoryType) {
    return categoryType == CategoryType.trendingMovies ||
        categoryType == CategoryType.popularMovies ||
        categoryType == CategoryType.topRatedMovies ||
        categoryType == CategoryType.nowPlayingMovies;
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryProvider(widget.categoryType));
    final isMovie = _isMovieCategory(widget.categoryType);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryType.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: categoryState.isLoading && categoryState.items.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading content...'),
                ],
              ),
            )
          : categoryState.items.isEmpty && !categoryState.isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isMovie ? Icons.movie : Icons.tv,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No content available',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        categoryState.errorMessage ?? 'Try refreshing or check back later',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(categoryProvider(widget.categoryType).notifier).refresh();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(categoryProvider(widget.categoryType).notifier).refresh();
                  },
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: categoryState.items.length + (categoryState.isLoadingMore ? 2 : 0),
                    itemBuilder: (context, index) {
                      // Show loading indicators at the bottom
                      if (index >= categoryState.items.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      
                      final item = categoryState.items[index];
                      
                      if (isMovie && item is TMDBMovie) {
                        return _MovieGridItem(movie: item);
                      } else if (!isMovie && item is TMDBTVShow) {
                        return _TVShowGridItem(tvShow: item);
                      }
                      
                      return const SizedBox.shrink();
                    },
                  ),
                ),
    );
  }
}

class _MovieGridItem extends StatelessWidget {
  final TMDBMovie movie;

  const _MovieGridItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/tmdb/movie/${movie.id}?title=${Uri.encodeComponent(movie.title)}&posterPath=${Uri.encodeComponent(movie.posterPath ?? '')}',
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: TMDBService.instance.getPosterUrl(movie.posterPath),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.movie, size: 40),
                        ),
                      ),
                    ),
                  ),
                  if (movie.voteAverage > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (movie.releaseDate?.isNotEmpty == true)
                    Text(
                      movie.releaseDate!.split('-')[0],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TVShowGridItem extends StatelessWidget {
  final TMDBTVShow tvShow;

  const _TVShowGridItem({required this.tvShow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/tmdb/tv/${tvShow.id}?title=${Uri.encodeComponent(tvShow.name)}&posterPath=${Uri.encodeComponent(tvShow.posterPath ?? '')}',
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: TMDBService.instance.getPosterUrl(tvShow.posterPath),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.tv, size: 40),
                        ),
                      ),
                    ),
                  ),
                  if (tvShow.voteAverage > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              tvShow.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tvShow.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (tvShow.firstAirDate?.isNotEmpty == true)
                    Text(
                      tvShow.firstAirDate!.split('-')[0],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}