import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../data/models/tmdb_models.dart';
import '../../services/tmdb_service.dart';

class FeaturedCard extends StatefulWidget {
  final TMDBMovie? movie;
  final TMDBTVShow? tvShow;
  final double height;
  final bool isFavorite;
  final Function(Color)? onDominantColorChange;
  final VoidCallback? onWatchNow;
  final VoidCallback? onFavorite;
  final VoidCallback? onInfo;

  const FeaturedCard({
    super.key,
    this.movie,
    this.tvShow,
    this.height = 500,
    this.isFavorite = false,
    this.onDominantColorChange,
    this.onWatchNow,
    this.onFavorite,
    this.onInfo,
  });

  @override
  State<FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<FeaturedCard> {
  Color _dominantColor = Colors.black;

  String get _title => widget.movie?.title ?? widget.tvShow?.name ?? '';
  String get _overview => widget.movie?.overview ?? widget.tvShow?.overview ?? '';
  String? get _backdropPath => widget.movie?.backdropPath ?? widget.tvShow?.backdropPath;
  double get _voteAverage => widget.movie?.voteAverage ?? widget.tvShow?.voteAverage ?? 0.0;

  @override
  void initState() {
    super.initState();
    _extractDominantColor();
  }

  Future<void> _extractDominantColor() async {
    if (_backdropPath?.isNotEmpty ?? false) {
      try {
        final imageUrl = TMDBService.instance.getBackdropUrl(_backdropPath!, size: 'w1280');
        final imageProvider = CachedNetworkImageProvider(imageUrl);
        
        final paletteGenerator = await PaletteGenerator.fromImageProvider(
          imageProvider,
          maximumColorCount: 10,
        );
        
        final dominantColor = paletteGenerator.dominantColor?.color ?? 
                             paletteGenerator.vibrantColor?.color ?? 
                             paletteGenerator.mutedColor?.color ?? 
                             Colors.black;
        
        setState(() {
          _dominantColor = dominantColor;
        });
        
        widget.onDominantColorChange?.call(dominantColor);
      } catch (e) {
        // Fallback to default color
        setState(() {
          _dominantColor = Colors.black;
        });
        widget.onDominantColorChange?.call(Colors.black);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onInfo,
      child: Container(
        height: widget.height,
        child: Stack(
          children: [
            // Background Image
            if (_backdropPath?.isNotEmpty ?? false)
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: TMDBService.instance.getBackdropUrl(_backdropPath!, size: 'w1280'),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[900],
                    child: const Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      _dominantColor.withOpacity(0.3),
                      _dominantColor.withOpacity(0.7),
                      _dominantColor,
                    ],
                    stops: const [0.0, 0.4, 0.8, 1.0],
                  ),
                ),
              ),
            ),
            
            // Content
            Positioned(
              left: 20,
              right: 20,
              bottom: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    _title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        const Shadow(
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
                  
                  // Rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _voteAverage.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Overview
                  if (_overview.isNotEmpty)
                    Text(
                      _overview,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  
                  const SizedBox(height: 20),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: widget.onWatchNow,
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Watch Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: IconButton(
                          onPressed: widget.onFavorite,
                          icon: Icon(
                            widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: widget.isFavorite ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: IconButton(
                          onPressed: widget.onInfo,
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                        ),
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

// We'll add this method to TMDBService instead of using extension