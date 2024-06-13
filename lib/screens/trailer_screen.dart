import 'package:flutter/material.dart';
import '../widgets/videoplayer_widget.dart';
import 'homepage.dart'; // Import your homepage screen file

class FullScreenVideoScreen extends StatelessWidget {
  final String videoUrl;

  const FullScreenVideoScreen({
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Ensure background is black for video visibility
      body: Stack(
        children: [
          VideoPlayerWidget(
            videoUrl: videoUrl,
            isFullScreen: true,
          ),
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
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
}
