import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends StatefulWidget {
  final String streamUrl;
  final String title;
  final Map<String, String> headers;

  const PlayerPage({
    super.key,
    required this.streamUrl,
    required this.title,
    this.headers = const {},
  });

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    // Set landscape orientation for video playback
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // Hide system UI for immersive experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _initializePlayer() async {
    try {
      // Use provided headers, with fallback defaults
      final Map<String, String> finalHeaders = {
        'Referer': 'http://www.iyinghua.com/',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        ...widget.headers, // Override with provided headers
      };
      
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.streamUrl),
        httpHeaders: finalHeaders,
      );

      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
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
        autoInitialize: true,
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load video: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                            _errorMessage = '';
                          });
                          _initializePlayer();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _chewieController != null
                  ? Chewie(controller: _chewieController!)
                  : const Center(
                      child: Text(
                        'Video player not initialized',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
    );
  }

  @override
  void dispose() {
    // Restore system UI and orientation
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}