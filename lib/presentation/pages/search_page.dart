import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/tmdb_models.dart';
import '../../services/tmdb_service.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _searchController = TextEditingController();
  List<TMDBMovie> _movieResults = [];
  List<TMDBTVShow> _tvResults = [];
  bool _isLoading = false;
  String _selectedTab = 'movies';

  Future<void> _performSearch(String keyword) async {
    if (keyword.isEmpty) {
      setState(() {
        _movieResults = [];
        _tvResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final movies = await TMDBService.instance.searchMovies(keyword);
      final tvShows = await TMDBService.instance.searchTVShows(keyword);
      
      setState(() {
        _movieResults = movies;
        _tvResults = tvShows;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Search failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Search', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search for movies and TV shows...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white54),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _movieResults = [];
                      _tvResults = [];
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              onSubmitted: _performSearch,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    _movieResults = [];
                    _tvResults = [];
                  });
                }
              },
            ),
          ),
          
          // Tab buttons
          if (_movieResults.isNotEmpty || _tvResults.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 'movies'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 'movies' ? Colors.blue : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Movies (${_movieResults.length})',
                          style: TextStyle(
                            color: _selectedTab == 'movies' ? Colors.white : Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 'tv'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 'tv' ? Colors.blue : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'TV Shows (${_tvResults.length})',
                          style: TextStyle(
                            color: _selectedTab == 'tv' ? Colors.white : Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Content area
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  )
                : _movieResults.isEmpty && _tvResults.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 64,
                              color: Colors.white24,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Search for movies and TV shows',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final currentResults = _selectedTab == 'movies' ? _movieResults : _tvResults;
    
    if (currentResults.isEmpty) {
      return Center(
        child: Text(
          'No ${_selectedTab == 'movies' ? 'movies' : 'TV shows'} found',
          style: const TextStyle(color: Colors.white54, fontSize: 16),
        ),
      );
    }
    
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: currentResults.length,
      itemBuilder: (context, index) {
        if (_selectedTab == 'movies') {
          final movie = _movieResults[index];
          return _buildMovieCard(movie);
        } else {
          final tvShow = _tvResults[index];
          return _buildTVShowCard(tvShow);
        }
      },
    );
  }
  
  Widget _buildMovieCard(TMDBMovie movie) {
    return GestureDetector(
      onTap: () {
        context.push('/tmdb/movie/${movie.id}?title=${Uri.encodeComponent(movie.title)}&posterPath=${Uri.encodeComponent(movie.posterPath ?? '')}');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(0.05),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: movie.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: TMDBService.instance.getPosterUrl(movie.posterPath!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => Container(
                          color: Colors.white.withOpacity(0.1),
                          child: const Center(
                            child: CircularProgressIndicator(color: Colors.blue),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.white.withOpacity(0.1),
                          child: const Icon(Icons.movie, color: Colors.white54, size: 40),
                        ),
                      )
                    : Container(
                        color: Colors.white.withOpacity(0.1),
                        child: const Icon(Icons.movie, color: Colors.white54, size: 40),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (movie.voteAverage > 0) ...[
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                      if (movie.releaseDate?.isNotEmpty == true) ...[
                        const Spacer(),
                        Text(
                          movie.releaseDate!.substring(0, 4),
                          style: const TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
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
  
  Widget _buildTVShowCard(TMDBTVShow tvShow) {
    return GestureDetector(
      onTap: () {
        context.push('/tmdb/tv/${tvShow.id}?title=${Uri.encodeComponent(tvShow.name)}&posterPath=${Uri.encodeComponent(tvShow.posterPath ?? '')}');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(0.05),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: tvShow.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: TMDBService.instance.getPosterUrl(tvShow.posterPath!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => Container(
                          color: Colors.white.withOpacity(0.1),
                          child: const Center(
                            child: CircularProgressIndicator(color: Colors.blue),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.white.withOpacity(0.1),
                          child: const Icon(Icons.tv, color: Colors.white54, size: 40),
                        ),
                      )
                    : Container(
                        color: Colors.white.withOpacity(0.1),
                        child: const Icon(Icons.tv, color: Colors.white54, size: 40),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tvShow.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (tvShow.voteAverage > 0) ...[
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          tvShow.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                      if (tvShow.firstAirDate?.isNotEmpty == true) ...[
                        const Spacer(),
                        Text(
                          tvShow.firstAirDate!.substring(0, 4),
                          style: const TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}