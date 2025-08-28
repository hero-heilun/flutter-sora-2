import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/library_models.dart';
import '../providers/library_provider.dart';
import '../../services/tmdb_service.dart';

class LibraryFavoritesPage extends ConsumerStatefulWidget {
  const LibraryFavoritesPage({super.key});

  @override
  ConsumerState<LibraryFavoritesPage> createState() => _LibraryFavoritesPageState();
}

class _LibraryFavoritesPageState extends ConsumerState<LibraryFavoritesPage> {
  String _searchQuery = '';
  String _selectedFilter = 'all'; // all, movie, tv

  @override
  Widget build(BuildContext context) {
    final libraryState = ref.watch(libraryProvider);
    final libraryNotifier = ref.read(libraryProvider.notifier);
    
    List<FavoriteItem> filteredFavorites = libraryState.favorites;
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filteredFavorites = filteredFavorites.where((item) {
        return item.title.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    // Apply type filter
    if (_selectedFilter != 'all') {
      filteredFavorites = filteredFavorites.where((item) {
        return item.type == _selectedFilter;
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'all',
                child: Row(
                  children: [
                    Icon(_selectedFilter == 'all' ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                    const SizedBox(width: 8),
                    const Text('All'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'movie',
                child: Row(
                  children: [
                    Icon(_selectedFilter == 'movie' ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                    const SizedBox(width: 8),
                    const Text('Movies'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'tv',
                child: Row(
                  children: [
                    Icon(_selectedFilter == 'tv' ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                    const SizedBox(width: 8),
                    const Text('TV Shows'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search favorites...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text('${filteredFavorites.length} items'),
                const SizedBox(width: 8),
                if (_selectedFilter != 'all')
                  Chip(
                    label: Text(_selectedFilter == 'movie' ? 'Movies' : 'TV Shows'),
                    onDeleted: () {
                      setState(() {
                        _selectedFilter = 'all';
                      });
                    },
                  ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Favorites grid
          Expanded(
            child: libraryState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredFavorites.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _searchQuery.isNotEmpty ? Icons.search_off : Icons.favorite_border,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchQuery.isNotEmpty 
                                  ? 'No favorites found for "$_searchQuery"'
                                  : 'No favorites yet',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            if (_searchQuery.isEmpty) ...[
                              const SizedBox(height: 8),
                              const Text(
                                'Start adding items to your favorites to see them here',
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 2/3,
                        ),
                        itemCount: filteredFavorites.length,
                        itemBuilder: (context, index) {
                          final favorite = filteredFavorites[index];
                          return _buildFavoriteCard(favorite, libraryNotifier);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(FavoriteItem favorite, LibraryNotifier libraryNotifier) {
    return InkWell(
      onTap: () {
        // Navigate to details page
        context.push('/tmdb/${favorite.type}/${favorite.id}?title=${Uri.encodeComponent(favorite.title)}&posterPath=${Uri.encodeComponent(favorite.posterPath ?? '')}');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Poster image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: favorite.posterPath != null && favorite.posterPath!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: TMDBService.instance.getPosterUrl(favorite.posterPath!, size: 'w342'),
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
                          child: Icon(Icons.movie, size: 40, color: Colors.grey),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.movie, size: 40, color: Colors.grey),
                      ),
                    ),
            ),
            
            // Type badge
            Positioned(
              top: 4,
              left: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: favorite.type == 'movie' ? Colors.blue : Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  favorite.type == 'movie' ? 'Movie' : 'TV',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            // Remove button
            Positioned(
              top: 4,
              right: 4,
              child: InkWell(
                onTap: () async {
                  final confirmed = await _showRemoveDialog();
                  if (confirmed == true) {
                    await libraryNotifier.removeFromFavorites(favorite.id, favorite.type);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${favorite.title} removed from favorites'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
            
            // Title overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Text(
                  favorite.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showRemoveDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove from Favorites'),
        content: const Text('Are you sure you want to remove this item from your favorites?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}