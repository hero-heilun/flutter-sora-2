import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/library_models.dart';
import '../providers/library_provider.dart';
import '../../services/tmdb_service.dart';

class LibraryWatchHistoryPage extends ConsumerStatefulWidget {
  const LibraryWatchHistoryPage({super.key});

  @override
  ConsumerState<LibraryWatchHistoryPage> createState() => _LibraryWatchHistoryPageState();
}

class _LibraryWatchHistoryPageState extends ConsumerState<LibraryWatchHistoryPage> {
  String _searchQuery = '';
  String _selectedFilter = 'all'; // all, movie, tv

  @override
  Widget build(BuildContext context) {
    final libraryState = ref.watch(libraryProvider);
    final libraryNotifier = ref.read(libraryProvider.notifier);
    
    List<WatchHistoryItem> filteredHistory = libraryState.watchHistory;
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filteredHistory = filteredHistory.where((item) {
        final titleMatch = item.title.toLowerCase().contains(_searchQuery.toLowerCase());
        final episodeMatch = item.episodeTitle?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false;
        return titleMatch || episodeMatch;
      }).toList();
    }
    
    // Apply type filter
    if (_selectedFilter != 'all') {
      filteredHistory = filteredHistory.where((item) {
        return item.type == _selectedFilter;
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Continue Watching'),
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
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'clear_all') {
                _showClearAllDialog(libraryNotifier);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear_all',
                child: Row(
                  children: [
                    Icon(Icons.clear_all),
                    SizedBox(width: 8),
                    Text('Clear All History'),
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
                hintText: 'Search watch history...',
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
                Text('${filteredHistory.length} items'),
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
          
          // Watch history list
          Expanded(
            child: libraryState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredHistory.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _searchQuery.isNotEmpty ? Icons.search_off : Icons.history,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchQuery.isNotEmpty 
                                  ? 'No history found for "$_searchQuery"'
                                  : 'No watch history yet',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            if (_searchQuery.isEmpty) ...[
                              const SizedBox(height: 8),
                              const Text(
                                'Your watched content will appear here',
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredHistory.length,
                        itemBuilder: (context, index) {
                          final historyItem = filteredHistory[index];
                          return _buildHistoryCard(historyItem);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(WatchHistoryItem historyItem) {
    final progress = historyItem.duration > 0 
        ? historyItem.progress / historyItem.duration 
        : 0.0;
        
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Navigate to details page
          String route = '/tmdb/${historyItem.type}/${historyItem.id}?title=${Uri.encodeComponent(historyItem.title)}&posterPath=${Uri.encodeComponent(historyItem.posterPath ?? '')}';
          
          // Add season and episode parameters for TV shows
          if (historyItem.type == 'tv' && historyItem.seasonNumber != null && historyItem.episodeNumber != null) {
            route += '&seasonNumber=${historyItem.seasonNumber}&episodeNumber=${historyItem.episodeNumber}';
          }
          
          context.push(route);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 60,
                  height: 90,
                  child: historyItem.posterPath != null && historyItem.posterPath!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: TMDBService.instance.getPosterUrl(historyItem.posterPath!, size: 'w154'),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.movie, color: Colors.grey),
                          ),
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.movie, color: Colors.grey),
                        ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Content info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      historyItem.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Episode info (for TV shows)
                    if (historyItem.type == 'tv' && historyItem.episodeTitle != null) ...[
                      Text(
                        'S${historyItem.seasonNumber?.toString().padLeft(2, '0')}E${historyItem.episodeNumber?.toString().padLeft(2, '0')}: ${historyItem.episodeTitle}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                    ],
                    
                    // Type and last watched
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: historyItem.type == 'movie' ? Colors.blue : Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            historyItem.type == 'movie' ? 'Movie' : 'TV',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _formatDate(historyItem.lastWatched),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Progress bar
                    if (progress > 0) ...[
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progress.clamp(0.0, 1.0),
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${(progress * 100).round()}%',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    }
  }

  void _showClearAllDialog(LibraryNotifier libraryNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Watch History'),
        content: const Text('Are you sure you want to clear all your watch history? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await libraryNotifier.clearWatchHistory();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Watch history cleared'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}