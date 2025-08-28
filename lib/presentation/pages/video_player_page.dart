import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../data/models/search_result.dart';

class VideoPlayerPage extends StatefulWidget {
  final String streamUrl;
  final String title;
  final String? subtitle;
  final String? episodeTitle;

  const VideoPlayerPage({
    super.key,
    required this.streamUrl,
    required this.title,
    this.subtitle,
    this.episodeTitle,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _setupOrientations();
    _initializePlayer();
  }

  void _setupOrientations() {
    // Enable all orientations for video player
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future<void> _initializePlayer() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      // Initialize video player controller
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.streamUrl),
      );

      await _videoPlayerController.initialize();

      // Create Chewie controller for enhanced video controls
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        allowFullScreen: true,
        allowMuting: true,
        allowPlaybackSpeedChanging: true,
        showControlsOnInitialize: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
        systemOverlaysAfterFullScreen: SystemUiOverlay.values,
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blue,
          handleColor: Colors.blueAccent,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightBlue,
        ),
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'Video Error',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  errorMessage,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          );
        },
      );

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = error.toString();
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    
    // Hide status bar in landscape mode
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        statusBarBrightness: Brightness.dark,
      ),
    );
    
    if (isLandscape) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isLandscape ? null : AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (widget.episodeTitle != null) ...[
              Text(
                widget.episodeTitle!,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () => _showVideoInfo(),
          ),
        ],
      ),
      body: _buildBody(isLandscape),
    );
  }

  Widget _buildBody(bool isLandscape) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Loading video...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to load video',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'Unknown error occurred',
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _initializePlayer(),
                  child: const Text('Retry'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ],
        ),
      );
    }

    if (_chewieController != null) {
      return Stack(
        children: [
          Center(
            child: Chewie(
              controller: _chewieController!,
            ),
          ),
          if (isLandscape)
            Positioned(
              top: 40,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
        ],
      );
    }

    return const Center(
      child: Text(
        'Video player not available',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _showVideoInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Video Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${widget.title}'),
            if (widget.subtitle != null) Text('Subtitle: ${widget.subtitle}'),
            if (widget.episodeTitle != null)
              Text('Episode: ${widget.episodeTitle}'),
            const SizedBox(height: 8),
            Text('Stream URL: ${widget.streamUrl}'),
            if (_videoPlayerController.value.isInitialized) ...[
              const SizedBox(height: 8),
              Text(
                'Duration: ${_formatDuration(_videoPlayerController.value.duration)}',
              ),
              Text(
                'Resolution: ${_videoPlayerController.value.size.width.toInt()}x${_videoPlayerController.value.size.height.toInt()}',
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    
    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }
}