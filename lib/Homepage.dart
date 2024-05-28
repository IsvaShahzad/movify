import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';
import 'package:video_player/video_player.dart';

import 'full_screen.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late SubtitleController _subtitleController;
  bool _isAudioOn = true; // Track the state of audio (on/off)

  bool _showOverlay = false; // Flag to control overlay visibility

  bool _isVideoInitialized = false;
  // List of URLs for each item
  List<String> itemUrls = [
    'https://m.media-amazon.com/images/M/MV5BZWFlYmY2MGEtZjVkYS00YzU4LTg0YjQtYzY1ZGE3NTA5NGQxXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg',
    'https://i0.wp.com/bloody-disgusting.com/wp-content/uploads/2022/09/barbarian-art.jpg?ssl=1'
        'data:image/jpeg;base64,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',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShlNiqEjsNK47hTGb_63b2ZHgPe5e3qgjS0OwOgTTwgQ&s',
    'data:image/jpeg;base64,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',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMsiue3NYKIl_IdjN7Ha9c5Osn2guVxS6LJMD8i1nEBw&s'
  ];

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
        'assets/videos/dune3video.mp4',
      );

      await _videoPlayerController.initialize();

      _subtitleController = SubtitleController(
        subtitleUrl: 'assets/subtitles/subtitles.srt',
        subtitleType: SubtitleType.srt,
      );

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: true,
        showControls: false, // Hide controls
        allowFullScreen: true,
      );

      // Listen to video player state changes
      _videoPlayerController.addListener(() {
        if (_videoPlayerController.value.isPlaying) {
          // Video is playing, hide the overlay
          if (_showOverlay) {
            setState(() {
              _showOverlay = false;
            });
          }
        } else {
          // Video is paused or stopped, show the overlay
          if (!_showOverlay) {
            setState(() {
              _showOverlay = true;
            });
          }
        }
      });

      setState(() {
        _isVideoInitialized = true;
      });
    } catch (e) {
      print('Error initializing video player: $e');
      // Handle error gracefully, e.g., show an error message
    }
  }

  void _playVideoFullScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullScreenVideoScreen(
          videoUrl:
              'assets/videos/dune3video.mp4', // Replace with your video URL
        ),
      ),
    );
    _videoPlayerController
        .pause(); // Pause video when navigating to full-screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 17 / 9, // Adjust aspect ratio as needed
              child: _isVideoInitialized
                  ? Stack(
                      children: [
                        Chewie(
                          controller: _chewieController,
                        ),

                        Positioned(
                          bottom: 180,
                          left: 50,
                          child: Text(
                            'DUNE 2', // Replace with actual movie title
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 640, left: 50),
                          child: ElevatedButton(
                            onPressed: () {
                              _playVideoFullScreen(
                                  context); // Navigate to full-screen video
                            },
                            child: Text(
                              'Play Now',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              fixedSize: Size(
                                  160, 50), // Set fixed size for the button

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),

                                // Set border radius to 0 for a square shape
                              ),
                              // Background color
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 1350, top: 600),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white,
                                    width: 2.0

                                )

                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isAudioOn = !_isAudioOn; // Toggle audio state
                                });
                                print('_chewieController: $_chewieController');
                                if (_chewieController != null) {
                                  _chewieController!
                                      .setVolume(_isAudioOn ? 1.0 : 0.0);
                                } else {
                                  print('Warning: _chewieController is null');
                                }
                              },
                              child: Icon(
                                _isAudioOn ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 600, left: 1400),
                          child:
                          Container(
                            color: Colors.black54,
                            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.0), // Adjust the padding as needed
                            child: Text(
                              '18+',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )

                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            SizedBox(
              height: 10, // Adjust the height as needed to give less height
            ),

            Container(
              height: 350, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Replace with actual item count
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(0),
                        image: DecorationImage(
                          image: NetworkImage(
                              itemUrls[index]), // Placeholder image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20), // Add more widgets or sections here
          ],
        ),
      ),
    );
  }
}
