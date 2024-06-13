import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool isFullScreen;

  const VideoPlayerWidget({
    required this.videoUrl,
    this.isFullScreen = false,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
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
      _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);

      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: true,
        allowFullScreen: widget.isFullScreen,
        allowPlaybackSpeedChanging: false,
        showControls: true,
        fullScreenByDefault: widget.isFullScreen,
      );

      setState(() {
        _isVideoInitialized = true;
      });
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isVideoInitialized
        ? Chewie(
      controller: _chewieController,
    )
        : Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.isFullScreen) {
      _videoPlayerController.play();
    }
  }
}
