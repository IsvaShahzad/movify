import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'mainpage_screen.dart'; // Import your homepage screen file

class FullScreenVideoScreen extends StatefulWidget {
  final String videoUrl;

  const FullScreenVideoScreen({
    required this.videoUrl,
  });

  @override
  _FullScreenVideoScreenState createState() => _FullScreenVideoScreenState();
}

class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.asset(
        widget.videoUrl,
      );

      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: true, // Auto play in fullscreen mode
        looping: true,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: false, // Disable playback speed controls
        showControls: true, // Show controls in fullscreen mode
        fullScreenByDefault: true, // Enter fullscreen mode by default
      );

      setState(() {
        _isVideoInitialized = true;
      });
    } catch (e) {
      print('Error initializing video player: $e');
      // Handle error gracefully, e.g., show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Ensure background is black for video visibility
      body: Stack(
        children: [
          _isVideoInitialized
              ? Chewie(
            controller: _chewieController,
          )
              : Center(
            child: CircularProgressIndicator(),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                _videoPlayerController
                    .pause();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageScreen()),
                );
                },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Resume video playback when returning to the home screen
    _videoPlayerController.play();
  }
}
