import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:go_router/go_router.dart';
import '../../main.dart';
import '../../data/models/tmdb_models.dart';
import '../../data/models/service_search_result.dart';
import '../../services/tmdb_service.dart';
import '../../services/service_manager.dart';
import '../providers/tmdb_details_provider.dart';
import '../providers/app_state_provider.dart';
import '../../data/models/search_result.dart';
import '../../services/similarity_algorithm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TMDBDetailsPage extends ConsumerStatefulWidget {
  final int id;
  final String type; // 'movie' or 'tv'
  final String title;
  final String? posterPath;

  const TMDBDetailsPage({
    super.key,
    required this.id,
    required this.type,
    required this.title,
    this.posterPath,
  });

  @override
  ConsumerState<TMDBDetailsPage> createState() => _TMDBDetailsPageState();
}

class _TMDBDetailsPageState extends ConsumerState<TMDBDetailsPage> {
  Color _dominantColor = const Color(0xFF1a1a1a);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _extractDominantColor();
    // Delay the provider modification until after the build
    Future.microtask(() => _loadDetails());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadDetails() {
    final detailsNotifier = ref.read(tmdbDetailsProvider.notifier);
    detailsNotifier.reset();
    
    if (widget.type == 'movie') {
      detailsNotifier.loadMovieDetails(widget.id);
    } else {
      detailsNotifier.loadTVShowDetails(widget.id);
    }
  }

  Future<void> _extractDominantColor() async {
    if (widget.posterPath?.isNotEmpty ?? false) {
      try {
        final imageUrl = TMDBService.instance.getBackdropUrl(widget.posterPath!, size: 'w780');
        final imageProvider = CachedNetworkImageProvider(imageUrl);
        
        final paletteGenerator = await PaletteGenerator.fromImageProvider(
          imageProvider,
          maximumColorCount: 10,
        );
        
        final dominantColor = paletteGenerator.dominantColor?.color ?? 
                             paletteGenerator.vibrantColor?.color ?? 
                             paletteGenerator.mutedColor?.color ?? 
                             const Color(0xFF1a1a1a);
        
        if (mounted) {
          setState(() {
            _dominantColor = dominantColor;
          });
        }
      } catch (e) {
        // Use default color if extraction fails
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailsState = ref.watch(tmdbDetailsProvider);
    
    return Scaffold(
      backgroundColor: _dominantColor,
      body: detailsState.isLoading
          ? _buildLoadingView()
          : detailsState.errorMessage != null
              ? _buildErrorView(detailsState.errorMessage!)
              : _buildDetailsView(detailsState),
    );
  }

  Widget _buildLoadingView() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_dominantColor, _dominantColor.withOpacity(0.8)],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Loading details...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(String error) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_dominantColor, _dominantColor.withOpacity(0.8)],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load details',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadDetails,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: _dominantColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsView(TMDBDetailsState state) {
    final movieDetail = state.movieDetail;
    final tvShowDetail = state.tvShowDetail;
    
    String? backdropPath = movieDetail?.backdropPath ?? tvShowDetail?.backdropPath ?? widget.posterPath;
    String overview = movieDetail?.overview ?? tvShowDetail?.overview ?? 'No overview available.';
    String title = movieDetail?.title ?? tvShowDetail?.name ?? widget.title;
    
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // Hero image section
        SliverAppBar(
          expandedHeight: 500,
          pinned: true,
          backgroundColor: _dominantColor,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.bookmark_border, color: Colors.white, size: 20),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bookmark functionality coming soon...')),
                );
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                // Background image
                if (backdropPath != null && backdropPath.isNotEmpty)
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: TMDBService.instance.getBackdropUrl(backdropPath, size: 'w1280'),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: _dominantColor.withOpacity(0.7),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: _dominantColor.withOpacity(0.7),
                        child: const Center(
                          child: Icon(Icons.movie, color: Colors.white, size: 80),
                        ),
                      ),
                    ),
                  ),
                // Gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          _dominantColor.withOpacity(0.3),
                          _dominantColor.withOpacity(0.8),
                          _dominantColor,
                        ],
                        stops: const [0.0, 0.4, 0.8, 1.0],
                      ),
                    ),
                  ),
                ),
                // Title and metadata
                Positioned(
                  bottom: 80,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      _buildMetadataRow(movieDetail, tvShowDetail),
                    ],
                  ),
                ),
                // Play button
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _handlePlayContent(context),
                          icon: const Icon(Icons.play_arrow, size: 24),
                          label: Text(
                            widget.type == 'movie' ? 'Play Movie' : 'Play Show',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Content section
        SliverToBoxAdapter(
          child: Container(
            color: _dominantColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Overview section
                if (overview.isNotEmpty) _buildOverviewSection(overview),
                
                // Details section
                _buildDetailsSection(movieDetail, tvShowDetail),
                
                // TV Show seasons section
                if (widget.type == 'tv' && state.tvShowDetail != null)
                  _buildSeasonsSection(state),
                
                const SizedBox(height: 100), // Bottom padding
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetadataRow(TMDBMovieDetail? movieDetail, TMDBTVShowDetail? tvShowDetail) {
    List<Widget> metadata = [];
    
    // Rating
    double rating = movieDetail?.voteAverage ?? tvShowDetail?.voteAverage ?? 0.0;
    if (rating > 0) {
      metadata.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
    
    // Year
    String? date = movieDetail?.releaseDate ?? tvShowDetail?.firstAirDate;
    if (date != null && date.isNotEmpty) {
      if (metadata.isNotEmpty) metadata.add(const Text('  •  ', style: TextStyle(color: Colors.white70)));
      metadata.add(
        Text(
          date.split('-')[0],
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      );
    }
    
    // Runtime/Episodes
    if (movieDetail?.runtime != null) {
      if (metadata.isNotEmpty) metadata.add(const Text('  •  ', style: TextStyle(color: Colors.white70)));
      final runtime = movieDetail!.runtime!;
      final hours = runtime ~/ 60;
      final minutes = runtime % 60;
      metadata.add(
        Text(
          hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m',
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      );
    } else if (tvShowDetail?.numberOfEpisodes != null) {
      if (metadata.isNotEmpty) metadata.add(const Text('  •  ', style: TextStyle(color: Colors.white70)));
      metadata.add(
        Text(
          '${tvShowDetail!.numberOfEpisodes} episodes',
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      );
    }
    
    return Row(children: metadata);
  }

  Widget _buildOverviewSection(String overview) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            overview,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(TMDBMovieDetail? movieDetail, TMDBTVShowDetail? tvShowDetail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                if (tvShowDetail?.numberOfSeasons != null)
                  _buildInfoRow('Seasons', tvShowDetail!.numberOfSeasons.toString()),
                
                if (tvShowDetail?.numberOfEpisodes != null)
                  _buildInfoRow('Episodes', tvShowDetail!.numberOfEpisodes.toString()),
                
                if (movieDetail?.genres.isNotEmpty == true || tvShowDetail?.genres.isNotEmpty == true)
                  _buildInfoRow('Genres', 
                    (movieDetail?.genres ?? tvShowDetail?.genres ?? [])
                        .map((g) => g.name)
                        .join(', ')
                  ),
                
                if (movieDetail?.voteAverage != null && movieDetail!.voteAverage > 0 || 
                    tvShowDetail?.voteAverage != null && tvShowDetail!.voteAverage > 0)
                  _buildInfoRow('Rating', 
                    '${(movieDetail?.voteAverage ?? tvShowDetail?.voteAverage ?? 0).toStringAsFixed(1)}/10'
                  ),
                
                if (movieDetail?.status != null || tvShowDetail?.status != null)
                  _buildInfoRow('Status', movieDetail?.status ?? tvShowDetail?.status ?? ''),
                
                if (movieDetail?.originalLanguage != null || tvShowDetail?.originalLanguage != null)
                  _buildInfoRow('Language', movieDetail?.originalLanguage ?? tvShowDetail?.originalLanguage ?? ''),
                
                if (movieDetail?.budget != null && movieDetail!.budget! > 0)
                  _buildInfoRow('Budget', '\$${_formatNumber(movieDetail.budget!)}'),
                
                if (movieDetail?.revenue != null && movieDetail!.revenue! > 0)
                  _buildInfoRow('Revenue', '\$${_formatNumber(movieDetail.revenue!)}'),
                
                _buildInfoRow('TMDB ID', widget.id.toString()),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSeasonsSection(TMDBDetailsState state) {
    final tvShow = state.tvShowDetail!;
    if (tvShow.numberOfSeasons == null || tvShow.numberOfSeasons! <= 0) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Seasons',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // Season selector with posters
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              itemCount: tvShow.numberOfSeasons!,
              itemBuilder: (context, index) {
                final seasonNumber = index + 1;
                final isSelected = state.selectedSeasonNumber == seasonNumber;
                
                // Find season detail for this season number
                final seasonDetail = state.seasonDetails.cast<TMDBSeasonDetail?>().firstWhere(
                  (season) => season?.seasonNumber == seasonNumber,
                  orElse: () => null,
                );
                
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      ref.read(tmdbDetailsProvider.notifier).selectSeason(widget.id, seasonNumber);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Season poster
                        Container(
                          width: 80,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? Colors.blue : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: seasonDetail?.posterPath != null && seasonDetail!.posterPath!.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: TMDBService.instance.getPosterUrl(seasonDetail.posterPath!, size: 'w342'),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => _buildSeasonPlaceholder(seasonNumber),
                                    errorWidget: (context, url, error) => _buildSeasonPlaceholder(seasonNumber),
                                  )
                                : _buildSeasonPlaceholder(seasonNumber),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Season name
                        SizedBox(
                          width: 80,
                          child: Text(
                            seasonDetail?.name ?? 'Season $seasonNumber',
                            style: TextStyle(
                              color: isSelected ? Colors.blue : Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Episodes list
          if (state.selectedSeasonNumber != null) _buildEpisodesList(state),
        ],
      ),
    );
  }

  Widget _buildEpisodesList(TMDBDetailsState state) {
    final seasonDetail = state.seasonDetails.firstWhere(
      (season) => season.seasonNumber == state.selectedSeasonNumber,
      orElse: () => const TMDBSeasonDetail(id: 0, seasonNumber: 0, episodes: []),
    );
    
    if (seasonDetail.episodes.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Loading episodes...',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: seasonDetail.episodes.length,
      itemBuilder: (context, index) {
        final episode = seasonDetail.episodes[index];
        return GestureDetector(
          onTap: () => _onEpisodeTap(episode),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Episode thumbnail or number
              Container(
                width: 80,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: episode.stillPath != null && episode.stillPath!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: TMDBService.instance.getImageUrl(episode.stillPath!, size: 'w300'),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.white.withOpacity(0.2),
                          child: Center(
                            child: Text(
                              '${episode.episodeNumber}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.white.withOpacity(0.2),
                          child: Center(
                            child: Text(
                              '${episode.episodeNumber}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.white.withOpacity(0.2),
                        child: Center(
                          child: Text(
                            '${episode.episodeNumber}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.name ?? 'Episode ${episode.episodeNumber}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (episode.overview?.isNotEmpty == true) ...[
                      const SizedBox(height: 4),
                      Text(
                        episode.overview!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (episode.airDate?.isNotEmpty == true) ...[
                          Text(
                            episode.airDate!,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                          if (episode.runtime != null) const Text(' • ', style: TextStyle(color: Colors.white60)),
                        ],
                        if (episode.runtime != null && episode.runtime! > 0) ...[
                          Text(
                            '${episode.runtime}m',
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                        if (episode.voteAverage > 0) ...[
                          const Text(' • ', style: TextStyle(color: Colors.white60)),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            episode.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
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
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonPlaceholder(int seasonNumber) {
    return Container(
      width: 80,
      height: 120,
      color: Colors.grey[800],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.tv,
            color: Colors.white54,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'S$seasonNumber',
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _onEpisodeTap(TMDBEpisode episode) {
    // Directly start service search for the episode (matching original Swift behavior)
    // This removes the intermediate dialog and goes straight to service search
    _handlePlayEpisode(context, episode);
  }

  String _formatNumber(int number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  void _handlePlayContent(BuildContext context) {
    final detailsState = ref.read(tmdbDetailsProvider);
    String searchQuery = '';
    
    if (widget.type == 'movie' && detailsState.movieDetail != null) {
      searchQuery = detailsState.movieDetail!.title;
    } else if (widget.type == 'tv' && detailsState.tvShowDetail != null) {
      searchQuery = detailsState.tvShowDetail!.name;
    }
    
    if (searchQuery.isNotEmpty) {
      _showServiceSearchDialog(context, searchQuery);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to determine content to search for')),
      );
    }
  }

  void _handlePlayEpisode(BuildContext context, TMDBEpisode episode) {
    final detailsState = ref.read(tmdbDetailsProvider);
    String searchQuery = '';
    
    if (detailsState.tvShowDetail != null) {
      searchQuery = detailsState.tvShowDetail!.name;
    }
    
    if (searchQuery.isNotEmpty) {
      _showServiceSearchDialog(
        context, 
        searchQuery, 
        episode: episode,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to determine show to search for')),
      );
    }
  }

  void _showServiceSearchDialog(BuildContext context, String searchQuery, {TMDBEpisode? episode}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ServiceSearchDialog(
        searchQuery: searchQuery,
        episode: episode,
        dominantColor: _dominantColor,
        tmdbId: widget.id,
        isMovie: widget.type == 'movie',
      ),
    );
  }
}

class ServiceSearchDialog extends ConsumerStatefulWidget {
  final String searchQuery;
  final TMDBEpisode? episode;
  final Color dominantColor;
  final int tmdbId;
  final bool isMovie;

  const ServiceSearchDialog({
    super.key,
    required this.searchQuery,
    this.episode,
    required this.dominantColor,
    required this.tmdbId,
    required this.isMovie,
  });

  @override
  ConsumerState<ServiceSearchDialog> createState() => _ServiceSearchDialogState();
}

class _ServiceSearchDialogState extends ConsumerState<ServiceSearchDialog> {
  ServiceSearchProgress _searchProgress = ServiceSearchProgress(
    totalServices: 0,
    completedServices: 0,
    serviceResults: [],
  );
  String? _errorMessage;
  final Map<String, Set<String>> _expandedServices = {};
  double _qualityThreshold = 0.9;
  bool _showingQualityDialog = false;

  @override
  void initState() {
    super.initState();
    _loadQualityThreshold();
    // Delay the search to avoid modifying provider during build
    Future.microtask(() => _performMultiServiceSearch());
  }

  Future<void> _loadQualityThreshold() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _qualityThreshold = prefs.getDouble('quality_threshold') ?? 0.9;
    });
  }

  Future<void> _performMultiServiceSearch() async {
    try {
      final services = ref.read(servicesProvider);
      final activeServices = services.where((s) => s.isActive).toList();
      
      if (activeServices.isEmpty) {
        setState(() {
          _errorMessage = 'No services activated. Please activate services in Settings.';
        });
        return;
      }

      // Initialize search progress with only active services
      setState(() {
        _searchProgress = ServiceSearchProgress(
          totalServices: activeServices.length,
          completedServices: 0,
          serviceResults: activeServices.map((service) => ServiceSearchResult(
            serviceId: service.id,
            serviceName: service.metadata.sourceName,
            serviceIcon: service.metadata.iconUrl,
            status: ServiceSearchStatus.loading,
          )).toList(),
        );
        _errorMessage = null;
      });

      // Search all active services concurrently
      final futures = activeServices.map((service) => _searchService(service));
      await Future.wait(futures);
      
    } catch (e) {
      setState(() {
        _errorMessage = 'Search failed: $e';
      });
    }
  }

  Future<void> _searchService(Service service) async {
    try {
      // Search using this specific service without changing the active service
      final results = await ServiceManager.instance.searchWithService(service.id, widget.searchQuery);

      // Filter out invalid/error results
      final filteredResults = results.where((result) {
        // Filter out results with "Error" as title or empty href
        return result.title.toLowerCase() != 'error' && 
               result.title.trim().isNotEmpty &&
               result.href.trim().isNotEmpty;
      }).toList();

      // Update this service's results
      setState(() {
        final serviceIndex = _searchProgress.serviceResults.indexWhere(
          (s) => s.serviceId == service.id,
        );
        
        if (serviceIndex != -1) {
          _searchProgress.serviceResults[serviceIndex] = ServiceSearchResult(
            serviceId: service.id,
            serviceName: service.metadata.sourceName,
            serviceIcon: service.metadata.iconUrl,
            status: ServiceSearchStatus.completed,
            results: filteredResults,
          );
          
          _searchProgress = _searchProgress.copyWith(
            completedServices: _searchProgress.serviceResults
                .where((s) => s.status != ServiceSearchStatus.loading)
                .length,
          );
        }
      });
      
    } catch (e) {
      // Update this service with error
      setState(() {
        final serviceIndex = _searchProgress.serviceResults.indexWhere(
          (s) => s.serviceId == service.id,
        );
        
        if (serviceIndex != -1) {
          _searchProgress.serviceResults[serviceIndex] = ServiceSearchResult(
            serviceId: service.id,
            serviceName: service.metadata.sourceName,
            serviceIcon: service.metadata.iconUrl,
            status: ServiceSearchStatus.error,
            errorMessage: e.toString(),
          );
          
          _searchProgress = _searchProgress.copyWith(
            completedServices: _searchProgress.serviceResults
                .where((s) => s.status != ServiceSearchStatus.loading)
                .length,
          );
        }
      });
    }
  }

  (List<SearchItem>, List<SearchItem>) _filterResultsByQuality(List<SearchItem> results) {
    if (results.isEmpty) return ([], []);
    
    final resultsWithScores = results.map((result) {
      final similarity = SimilarityCalculator.calculateSimilarity(widget.searchQuery, result.title);
      return (result: result, similarity: similarity);
    }).toList()
      ..sort((a, b) => b.similarity.compareTo(a.similarity));
    
    final highQuality = resultsWithScores
        .where((item) => item.similarity >= _qualityThreshold)
        .map((item) => item.result)
        .toList();
    
    final lowQuality = resultsWithScores
        .where((item) => item.similarity < _qualityThreshold)
        .map((item) => item.result)
        .toList();
    
    return (highQuality, lowQuality);
  }

  double _calculateSimilarity(String result) {
    return SimilarityCalculator.calculateSimilarity(widget.searchQuery, result);
  }

  @override
  Widget build(BuildContext context) {
    final dialog = AlertDialog(
      backgroundColor: widget.dominantColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.episode != null 
                ? 'Find Episode' 
                : 'Find Content',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            'Searching: "${widget.searchQuery}"',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          if (widget.episode != null) ...[
            const SizedBox(height: 4),
            Text(
              'Season ${widget.episode!.seasonNumber}, Episode ${widget.episode!.episodeNumber}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Column(
          children: [
            // Toolbar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PopupMenuButton<SimilarityAlgorithm>(
                    icon: const Icon(Icons.tune, color: Colors.white70),
                    onSelected: (algorithm) {
                      setState(() {
                        SimilarityCalculator.selectedAlgorithm = algorithm;
                      });
                    },
                    itemBuilder: (context) => SimilarityAlgorithm.values.map((algorithm) => 
                      PopupMenuItem(
                        value: algorithm,
                        child: Row(
                          children: [
                            if (SimilarityCalculator.selectedAlgorithm == algorithm)
                              const Icon(Icons.check, size: 16, color: Colors.green)
                            else
                              const SizedBox(width: 16),
                            const SizedBox(width: 8),
                            Text(algorithm.displayName),
                          ],
                        ),
                      )
                    ).toList(),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _showingQualityDialog = true),
                    child: Text(
                      'Quality: ${(_qualityThreshold * 100).round()}%',
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.white24),
            // Progress header
            if (_searchProgress.totalServices > 0) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Services: ${_searchProgress.completedServices}/${_searchProgress.totalServices}',
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    if (_searchProgress.isCompleted)
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 16),
                          SizedBox(width: 4),
                          Text('Completed', style: TextStyle(color: Colors.green, fontSize: 12)),
                        ],
                      )
                    else
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          value: _searchProgress.progress,
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Total Results: ${_searchProgress.totalResultsCount}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 16),
            ],
            
            // Results list
            Expanded(
              child: _errorMessage != null
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _errorMessage!.contains('No services configured') 
                                ? Icons.settings 
                                : Icons.error,
                            color: _errorMessage!.contains('No services configured') 
                                ? Colors.orange 
                                : Colors.red,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          if (_errorMessage!.contains('No services configured'))
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pop();
                                context.push('/settings');
                              },
                              icon: const Icon(Icons.settings),
                              label: const Text('Go to Settings'),
                            )
                          else
                            ElevatedButton(
                              onPressed: _performMultiServiceSearch,
                              child: const Text('Retry'),
                            ),
                        ],
                      ),
                    )
                  : _searchProgress.totalResultsCount == 0 && _searchProgress.isCompleted
                      ? const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off, color: Colors.white54, size: 48),
                              SizedBox(height: 16),
                              Text(
                                'No results found',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _searchProgress.serviceResults.length,
                          itemBuilder: (context, serviceIndex) {
                            final serviceResult = _searchProgress.serviceResults[serviceIndex];
                            return _buildServiceResultSection(serviceResult);
                          },
                        ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close', style: TextStyle(color: Colors.white)),
        ),
      ],
    );

    // Show quality dialog if needed
    if (_showingQualityDialog) {
      _showingQualityDialog = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showQualityThresholdDialog();
      });
    }

    return dialog;
  }

  Future<void> _showQualityThresholdDialog() async {
    final TextEditingController controller = TextEditingController(
      text: (_qualityThreshold * 100).round().toString(),
    );
    
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: widget.dominantColor,
        title: const Text(
          'Quality Threshold',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Set the minimum similarity score (0-100%) for results to be considered high quality.',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter percentage (e.g., 90)',
                hintStyle: const TextStyle(color: Colors.white54),
                suffixText: '%',
                suffixStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white54),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white54),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () async {
              final value = int.tryParse(controller.text);
              if (value != null && value >= 0 && value <= 100) {
                final newThreshold = value / 100.0;
                setState(() {
                  _qualityThreshold = newThreshold;
                });
                
                // Save to preferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.setDouble('quality_threshold', newThreshold);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Save', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceResultSection(ServiceSearchResult serviceResult) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Service header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              // Service icon
              if (serviceResult.serviceIcon.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: serviceResult.serviceIcon,
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 20,
                      height: 20,
                      color: Colors.white.withValues(alpha: 0.1),
                      child: const Icon(Icons.public, color: Colors.white54, size: 12),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 20,
                      height: 20,
                      color: Colors.white.withValues(alpha: 0.1),
                      child: const Icon(Icons.public, color: Colors.white54, size: 12),
                    ),
                  ),
                )
              else
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.public, color: Colors.white54, size: 12),
                ),
              const SizedBox(width: 8),
              
              // Service name and status
              Expanded(
                child: Text(
                  serviceResult.serviceName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              // Status indicator
              if (serviceResult.status == ServiceSearchStatus.loading)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white54,
                  ),
                )
              else if (serviceResult.status == ServiceSearchStatus.error)
                Icon(
                  Icons.error_outline,
                  color: Colors.red[300],
                  size: 16,
                )
              else if (serviceResult.status == ServiceSearchStatus.completed)
                Text(
                  '${serviceResult.results.length}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ),
        
        // Results for this service
        if (serviceResult.status == ServiceSearchStatus.error && serviceResult.errorMessage != null)
          Container(
            margin: const EdgeInsets.only(left: 28, bottom: 16),
            child: Text(
              'Error: ${serviceResult.errorMessage}',
              style: TextStyle(
                color: Colors.red[300],
                fontSize: 12,
              ),
            ),
          )
        else if (serviceResult.status == ServiceSearchStatus.completed && serviceResult.results.isEmpty)
          Container(
            margin: const EdgeInsets.only(left: 28, bottom: 16),
            child: const Text(
              'No results found',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          )
        else if (serviceResult.status == ServiceSearchStatus.completed)
          _buildFilteredResults(serviceResult)
        else
          Container(),
        
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildFilteredResults(ServiceSearchResult serviceResult) {
    final (highQuality, lowQuality) = _filterResultsByQuality(serviceResult.results);
    final serviceKey = serviceResult.serviceId;
    final isExpanded = _expandedServices[serviceKey] != null;

    return Column(
      children: [
        // High quality results (always visible)
        ...highQuality.map((result) => _buildResultCard(result, true)),
        
        // Low quality results (collapsible)
        if (lowQuality.isNotEmpty) ...[
          InkWell(
            onTap: () {
              setState(() {
                if (isExpanded) {
                  // Collapse - remove the key entirely
                  _expandedServices.remove(serviceKey);
                } else {
                  // Expand - add the key with result IDs
                  _expandedServices[serviceKey] = lowQuality.map((r) => r.id ?? '').where((id) => id.isNotEmpty).toSet();
                }
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.orange[300],
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${lowQuality.length} lower quality result${lowQuality.length == 1 ? '' : 's'} (<${(_qualityThreshold * 100).round()}%)',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white54,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            ...lowQuality.map((result) => _buildResultCard(result, false)),
        ],
      ],
    );
  }

  Widget _buildResultCard(SearchItem result, bool isHighQuality) {
    final similarity = _calculateSimilarity(result.title);
    final scoreColor = isHighQuality ? Colors.green : 
                      similarity >= 0.75 ? Colors.orange : Colors.red;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        color: Colors.white.withValues(alpha: isHighQuality ? 0.1 : 0.05),
        child: ListTile(
          dense: true,
          leading: Stack(
            children: [
              Container(
                width: 50,
                height: 70,
                child: result.imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: result.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.white.withValues(alpha: 0.1),
                          child: const Icon(Icons.movie, color: Colors.white54, size: 16),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.white.withValues(alpha: 0.1),
                          child: const Icon(Icons.movie, color: Colors.white54, size: 16),
                        ),
                      )
                    : Container(
                        color: Colors.white.withValues(alpha: 0.1),
                        child: const Icon(Icons.movie, color: Colors.white54, size: 16),
                      ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: scoreColor.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${(similarity * 100).round()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            result.title,
            style: TextStyle(
              color: isHighQuality ? Colors.white : Colors.white70,
              fontSize: 13,
              fontWeight: isHighQuality ? FontWeight.w500 : FontWeight.normal,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: result.href.isNotEmpty 
              ? Text(
                  'Source: ${result.href.split('/').take(3).join('/')}',
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: scoreColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.play_arrow,
                color: isHighQuality ? Colors.blue : Colors.white54,
                size: 20,
              ),
            ],
          ),
          onTap: () async {
            Navigator.of(context).pop(); // Close search dialog first
            _showStreamingDialog(context, result);
          },
        ),
      ),
    );
  }

  void _showStreamingDialog(BuildContext context, SearchItem result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StreamingProgressDialog(
        result: result,
        episode: widget.episode,
        dominantColor: widget.dominantColor,
        onComplete: () {
          // Close the search dialog
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> _handleStreamingDirectly(SearchItem result) async {
    try {
      // Get episode details from the service
      final episodes = await ServiceManager.instance.getEpisodes(result.href);
      
      if (episodes.isEmpty) {
        return;
      }

      String targetEpisodeUrl;
      
      if (widget.episode != null) {
        // For TV shows, find the specific episode
        final targetEpisode = episodes.firstWhere(
          (ep) => ep.number == widget.episode!.episodeNumber,
          orElse: () => episodes.first,
        );
        targetEpisodeUrl = targetEpisode.href;
        
      } else {
        // For movies, use first episode/stream
        targetEpisodeUrl = episodes.first.href;
      }

      // Get stream URL
      final streamData = await ServiceManager.instance.getStreamUrl(targetEpisodeUrl);
      
      if (streamData != null && streamData.streams.isNotEmpty) {
        final streamUrl = streamData.streams.first.url;
        
        // Validate that we have a proper URL string, not a JSON object
        if (streamUrl.isEmpty || streamUrl.startsWith('{')) {
          throw Exception('Invalid stream URL: Expected URL string but got: $streamUrl');
        }
        
        // Build episode title if available
        String? episodeTitle;
        if (widget.episode != null) {
          episodeTitle = 'S${widget.episode!.seasonNumber}E${widget.episode!.episodeNumber}';
          if (widget.episode!.name?.isNotEmpty == true) {
            episodeTitle += ' - ${widget.episode!.name}';
          }
        }
        
        // Navigate to video player
        // Ensure proper URL encoding for special characters
        final encodedStreamUrl = Uri.encodeComponent(streamUrl);
        
        final queryParams = <String, String>{
          'streamUrl': encodedStreamUrl,
          'title': Uri.encodeComponent(result.title),
          if (episodeTitle != null) 'episodeTitle': Uri.encodeComponent(episodeTitle),
        };
        
        final uri = Uri(path: '/video_player', queryParameters: queryParams);
        
        // Use global navigator to ensure navigation works
        final globalContext = navigatorKey.currentContext;
        if (globalContext != null) {
          globalContext.push(uri.toString());
        } else {
        }
      } else {
      }
      
    } catch (e) {
    }
  }

}

class StreamingProgressDialog extends StatefulWidget {
  final SearchItem result;
  final TMDBEpisode? episode;
  final Color dominantColor;
  final VoidCallback onComplete;

  const StreamingProgressDialog({
    super.key,
    required this.result,
    this.episode,
    required this.dominantColor,
    required this.onComplete,
  });

  @override
  State<StreamingProgressDialog> createState() => _StreamingProgressDialogState();
}

class _StreamingProgressDialogState extends State<StreamingProgressDialog> {
  String _currentStatus = 'Getting episode details...';
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startStreamingProcess();
  }

  Future<void> _startStreamingProcess() async {
    try {
      setState(() {
        _currentStatus = 'Getting episode details...';
        _isLoading = true;
        _errorMessage = null;
      });

      // Get episode details from the service
      final episodes = await ServiceManager.instance.getEpisodes(widget.result.href);
      
      if (episodes.isEmpty) {
        setState(() {
          _errorMessage = 'No episodes found for this content';
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _currentStatus = 'Finding target episode...';
      });

      String targetEpisodeUrl;
      
      if (widget.episode != null) {
        // For TV shows, find the specific episode
        final targetEpisode = episodes.firstWhere(
          (ep) => ep.number == widget.episode!.episodeNumber,
          orElse: () => episodes.first,
        );
        targetEpisodeUrl = targetEpisode.href;
      } else {
        // For movies, use first episode/stream
        targetEpisodeUrl = episodes.first.href;
      }

      setState(() {
        _currentStatus = 'Getting stream URL...';
      });

      // Get stream URL
      final streamData = await ServiceManager.instance.getStreamUrl(targetEpisodeUrl);
      
      if (streamData != null && streamData.streams.isNotEmpty) {
        final streamUrl = streamData.streams.first.url;
        
        // Validate that we have a proper URL string, not a JSON object
        if (streamUrl.isEmpty || streamUrl.startsWith('{')) {
          throw Exception('Invalid stream URL format');
        }

        setState(() {
          _currentStatus = 'Launching video player...';
        });

        // Build episode title if available
        String? episodeTitle;
        if (widget.episode != null) {
          episodeTitle = 'S${widget.episode!.seasonNumber}E${widget.episode!.episodeNumber}';
          if (widget.episode!.name?.isNotEmpty == true) {
            episodeTitle += ' - ${widget.episode!.name}';
          }
        }
        
        // Navigate to video player
        final encodedStreamUrl = Uri.encodeComponent(streamUrl);
        
        final queryParams = <String, String>{
          'streamUrl': encodedStreamUrl,
          'title': Uri.encodeComponent(widget.result.title),
          if (episodeTitle != null) 'episodeTitle': Uri.encodeComponent(episodeTitle),
        };
        
        final uri = Uri(path: '/video_player', queryParameters: queryParams);
        
        // Use global navigator to ensure navigation works
        final globalContext = navigatorKey.currentContext;
        if (globalContext != null) {
          globalContext.push(uri.toString());
          
          // Close dialogs after successful navigation
          Navigator.of(context).pop(); // Close streaming dialog
          widget.onComplete(); // Close search dialog
        } else {
          throw Exception('Unable to navigate - no global context');
        }
      } else {
        setState(() {
          _errorMessage = 'No streams available for this content';
          _isLoading = false;
        });
      }
      
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.dominantColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preparing Stream',
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            widget.result.title,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (widget.episode != null) ...[
            const SizedBox(height: 2),
            Text(
              'S${widget.episode!.seasonNumber}E${widget.episode!.episodeNumber}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isLoading) ...[
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                _currentStatus,
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ] else if (_errorMessage != null) ...[
              const Icon(
                Icons.error_outline,
                color: Colors.redAccent,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
      actions: _isLoading ? [] : [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close streaming dialog
            if (_errorMessage != null) {
              // Don't close search dialog if there was an error
              return;
            }
            widget.onComplete(); // Close search dialog
          },
          child: Text(
            _errorMessage != null ? 'Try Another' : 'Close',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        if (_errorMessage != null)
          TextButton(
            onPressed: () {
              _startStreamingProcess(); // Retry
            },
            child: const Text(
              'Retry',
              style: TextStyle(color: Colors.blue),
            ),
          ),
      ],
    );
  }
}