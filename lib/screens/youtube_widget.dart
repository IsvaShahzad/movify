import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'homepage.dart';

class YoutubeScreen extends StatefulWidget {
  final String videoId;

  YoutubeScreen({required this.videoId});

  @override
  _YoutubeScreenState createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );

    _controller.setFullScreenListener((isFullScreen) {
      log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
    });

    // Load the video after the controller is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.loadVideoById(videoId: widget.videoId);
      _controller.enterFullScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return player; // Ensure the player takes the full screen space
            },
          ),        );
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}


