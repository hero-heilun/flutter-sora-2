import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/tmdb_provider.dart';
import '../../data/models/tmdb_models.dart';
import '../../services/tmdb_service.dart';
import '../widgets/featured_card.dart';
import '../../core/theme/accent_color_manager.dart';
import '../providers/library_provider.dart';
import 'search_page.dart';
import 'settings_page.dart';
import 'library_favorites_page.dart';
import 'library_watch_history_page.dart';
import 'library_bookmarks_page.dart';
import '../../services/javascript_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = const [
    HomeContent(),
    LibraryContent(),
    SearchPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends ConsumerStatefulWidget {
  const HomeContent({super.key});

  @override
  ConsumerState<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<HomeContent> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  TMDBMovie? _heroContent;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tmdbProvider.notifier).loadHomeContent();
    });
  }

  void _updateHeroContent(TMDBState tmdbState) {
    if (_heroContent == null && tmdbState.trendingMovies.isNotEmpty) {
      _heroContent = tmdbState.trendingMovies.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final tmdbState = ref.watch(tmdbProvider);
    final accentColorManager = ref.watch(accentColorManagerProvider);
    
    _updateHeroContent(tmdbState);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              accentColorManager.ambientColor,
              accentColorManager.ambientColor.withOpacity(0.8),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Hero Featured Content
            if (_heroContent != null)
              SliverToBoxAdapter(
                child: FeaturedCard(
                  movie: _heroContent,
                  height: 500,
                  onDominantColorChange: (color) {
                    final ambientColor = accentColorManager.generateAmbientColor(color);
                    accentColorManager.setAmbientColor(ambientColor);
                  },
                  onTap: () {
                    // Navigate to details
                  },
                ),
              ),
            
            if (tmdbState.isLoading)
              const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Loading content from TMDB...'),
                    ],
                  ),
                ),
              )
            else if (tmdbState.errorMessage != null)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 64, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        'Error loading content',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          tmdbState.errorMessage!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(tmdbProvider.notifier).loadHomeContent();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
              )
          else ...[
            // Trending Movies
            if (tmdbState.trendingMovies.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Trending This Week',
                  onSeeAll: () {
                    // Navigate to trending movies
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: _MovieList(movies: tmdbState.trendingMovies),
              ),
            ],

            // Popular Movies
            if (tmdbState.popularMovies.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Popular Movies',
                  onSeeAll: () {
                    // Navigate to popular movies
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: _MovieList(movies: tmdbState.popularMovies),
              ),
            ],

            // Top Rated Movies
            if (tmdbState.topRatedMovies.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Top Rated Movies',
                  onSeeAll: () {
                    // Navigate to top rated movies
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: _MovieList(movies: tmdbState.topRatedMovies),
              ),
            ],

            // Popular TV Shows
            if (tmdbState.popularTVShows.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Popular TV Shows',
                  onSeeAll: () {
                    // Navigate to popular TV shows
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: _TVShowList(tvShows: tmdbState.popularTVShows),
              ),
            ],

            // Popular Anime
            if (tmdbState.popularAnime.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Popular Anime',
                  onSeeAll: () {
                    // Navigate to popular anime
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: _TVShowList(tvShows: tmdbState.popularAnime),
              ),
            ],

            // Now Playing
            if (tmdbState.nowPlayingMovies.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Now Playing',
                  onSeeAll: () {
                    // Navigate to now playing movies
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: _MovieList(movies: tmdbState.nowPlayingMovies),
              ),
            ],

            // Top Rated TV Shows
            if (tmdbState.topRatedTVShows.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Top Rated TV Shows',
                  onSeeAll: () {
                    // Navigate to top rated TV shows
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: _TVShowList(tvShows: tmdbState.topRatedTVShows),
              ),
            ],

            // Top Rated Anime
            if (tmdbState.topRatedAnime.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Top Rated Anime',
                  onSeeAll: () {
                    // Navigate to top rated anime
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: _TVShowList(tvShows: tmdbState.topRatedAnime),
              ),
            ],
          ],
        ],
      ),
    ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const _SectionHeader({
    required this.title,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: const Text('See All'),
            ),
        ],
      ),
    );
  }
}

class _MovieList extends StatelessWidget {
  final List<TMDBMovie> movies;

  const _MovieList({required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260, // 195 (poster) + 8 (spacing) + 57 (title area)
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              context.push(
                '/tmdb/movie/${movie.id}?title=${Uri.encodeComponent(movie.title)}&posterPath=${Uri.encodeComponent(movie.posterPath ?? '')}',
              );
            },
            child: Container(
              width: 130,
              height: 260,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fixed aspect ratio container for consistent poster sizes
                Container(
                  width: 130,
                  height: 195, // 130 * 1.5 = standard movie poster ratio
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: TMDBService.instance.getPosterUrl(movie.posterPath),
                          fit: BoxFit.cover,
                          width: 130,
                          height: 195,
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
                      // Rating badge
                      if (movie.voteAverage > 0)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(4),
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
                const SizedBox(height: 8),
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (movie.releaseDate?.isNotEmpty == true)
                  Text(
                    movie.releaseDate!.split('-')[0], // Year only
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TVShowList extends StatelessWidget {
  final List<TMDBTVShow> tvShows;

  const _TVShowList({required this.tvShows});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260, // 195 (poster) + 8 (spacing) + 57 (title area)
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tvShows.length,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return GestureDetector(
            onTap: () {
              context.push(
                '/tmdb/tv/${tvShow.id}?title=${Uri.encodeComponent(tvShow.name)}&posterPath=${Uri.encodeComponent(tvShow.posterPath ?? '')}',
              );
            },
            child: Container(
              width: 130,
              height: 260,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fixed aspect ratio container for consistent poster sizes
                Container(
                  width: 130,
                  height: 195, // 130 * 1.5 = standard TV show poster ratio
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: TMDBService.instance.getPosterUrl(tvShow.posterPath),
                          fit: BoxFit.cover,
                          width: 130,
                          height: 195,
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
                      // Rating badge
                      if (tvShow.voteAverage > 0)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(4),
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
                const SizedBox(height: 8),
                Text(
                  tvShow.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (tvShow.firstAirDate?.isNotEmpty == true)
                  Text(
                    tvShow.firstAirDate!.split('-')[0], // Year only
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LibraryContent extends ConsumerWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryState = ref.watch(libraryProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh library data
            },
          ),
        ],
      ),
      body: libraryState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Favorites Section
                  _LibrarySection(
                    title: 'Favorites',
                    icon: Icons.favorite,
                    count: libraryState.favorites.length,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LibraryFavoritesPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Recent favorites preview
                  if (libraryState.favorites.isNotEmpty) ...[
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: libraryState.favorites.take(10).length,
                        itemBuilder: (context, index) {
                          final favorite = libraryState.favorites[index];
                          return Container(
                            width: 80,
                            margin: const EdgeInsets.only(right: 8),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl: favorite.posterPath != null
                                          ? TMDBService.instance.getPosterUrl(favorite.posterPath!)
                                          : '',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      placeholder: (context, url) => Container(
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.movie),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.movie),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  favorite.title,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  // Watch History Section
                  _LibrarySection(
                    title: 'Continue Watching',
                    icon: Icons.history,
                    count: libraryState.watchHistory.length,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LibraryWatchHistoryPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Recent watch history preview
                  if (libraryState.watchHistory.isNotEmpty) ...[
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: libraryState.watchHistory.take(5).length,
                        itemBuilder: (context, index) {
                          final historyItem = libraryState.watchHistory[index];
                          final progress = historyItem.duration > 0 
                              ? historyItem.progress / historyItem.duration 
                              : 0.0;
                              
                          return GestureDetector(
                            onTap: () {
                              String route = '/tmdb/${historyItem.type}/${historyItem.id}?title=${Uri.encodeComponent(historyItem.title)}&posterPath=${Uri.encodeComponent(historyItem.posterPath ?? '')}';
                              
                              // Add season and episode parameters for TV shows
                              if (historyItem.type == 'tv' && historyItem.seasonNumber != null && historyItem.episodeNumber != null) {
                                route += '&seasonNumber=${historyItem.seasonNumber}&episodeNumber=${historyItem.episodeNumber}';
                              }
                              
                              context.push(route);
                            },
                            child: Container(
                              width: 160,
                              margin: const EdgeInsets.only(right: 12),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: historyItem.posterPath != null
                                                ? TMDBService.instance.getPosterUrl(historyItem.posterPath!)
                                                : '',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            placeholder: (context, url) => Container(
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.movie),
                                            ),
                                            errorWidget: (context, url, error) => Container(
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.movie),
                                            ),
                                          ),
                                        ),
                                        if (progress > 0)
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              height: 3,
                                              child: LinearProgressIndicator(
                                                value: progress,
                                                backgroundColor: Colors.black54,
                                                valueColor: AlwaysStoppedAnimation<Color>(
                                                  Theme.of(context).primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    historyItem.title,
                                    style: Theme.of(context).textTheme.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (historyItem.episodeTitle != null)
                                    Text(
                                      historyItem.episodeTitle!,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  // Bookmarks Section
                  _LibrarySection(
                    title: 'Bookmarks',
                    icon: Icons.bookmark,
                    count: libraryState.bookmarks.length,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LibraryBookmarksPage(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Stats
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Stats',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatItem(
                              label: 'Favorites',
                              value: libraryState.favorites.length.toString(),
                              icon: Icons.favorite,
                            ),
                            _StatItem(
                              label: 'Watched',
                              value: libraryState.watchHistory.length.toString(),
                              icon: Icons.play_circle,
                            ),
                            _StatItem(
                              label: 'Bookmarks',
                              value: libraryState.bookmarks.length.toString(),
                              icon: Icons.bookmark,
                            ),
                          ],
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

class _LibrarySection extends StatelessWidget {
  final String title;
  final IconData icon;
  final int count;
  final VoidCallback onTap;

  const _LibrarySection({
    required this.title,
    required this.icon,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$count items',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}


