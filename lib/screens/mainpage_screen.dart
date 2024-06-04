import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/widgets/image_urls.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';
import 'package:video_player/video_player.dart';

import 'trailer_screen.dart';

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

      // _subtitleController = SubtitleController(
      //   subtitleUrl: 'assets/subtitles/subtitles.srt',
      //   subtitleType: SubtitleType.srt,
      // );

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: true,
        showControls: false, // Hide controls
        allowFullScreen: true,
      );

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
                          bottom: 200,
                          top: 340,
                          left: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DUNE 2', // Replace with actual movie title
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                              SizedBox(
                                  height: 10), // Adjust the height as needed
                              Text(
                                'In a universe rife with intrigue and betrayal, '
                                'a young leader rallies a band of rebels '
                                'against \nthose who destroyed his family. '
                                'Faced with an impossible choice between love '
                                'and the fate \nof humanity , '
                                'he must unlock the secrets of a dark prophecy to '
                                'avert a catastrophic \nfuture.',
                                // Replace with your text
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'Montserrat'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 550, left: 50),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _playVideoFullScreen(
                                      context); // Navigate to full-screen video
                                },
                                child: Text(
                                  'Play Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  fixedSize: Size(170, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 10), // Adjust spacing between buttons

                              // Trailer Button with Play Icon
                              ElevatedButton(
                                onPressed: () {
                                  _playVideoFullScreen(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  fixedSize: Size(170, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      color:
                                          Colors.red, // Color of the play icon
                                    ),
                                    SizedBox(
                                        width:
                                            8), // Adjust spacing between icon and text
                                    Text(
                                      'Trailer',
                                      style: TextStyle(
                                        color: Colors
                                            .black, // Text color of the trailer button
                                        fontSize: 20,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 1350, top: 450),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 2.0)),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isAudioOn =
                                      !_isAudioOn; // Toggle audio state
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
                                _isAudioOn
                                    ? Icons.volume_up_rounded
                                    : Icons.volume_off_rounded,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 450, left: 1400),
                          child: Container(
                            color: Colors.black54,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0,
                                vertical: 4.0), // Adjust the padding as needed
                            child: Text(
                              '18+',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
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

            Padding(
              padding: EdgeInsets.only(right: 1349),
              child: Text(
                'Top Picks',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 27,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              height: 330, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemslist1Urls.length, // Use the imported list
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(0),
                            image: DecorationImage(
                              image: NetworkImage(itemslist1Urls[index]
                                  ['url']!), // Use URL from the imported file
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors
                                        .transparent, // Make the dialog background transparent
                                    child: Container(
                                      width: 300,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(
                                            0.2), // Semi-transparent background
                                        border: Border.all(
                                            color: Colors.white,
                                            width: 2), // White border
                                      ),
                                      padding: EdgeInsets.all(
                                          20), // Padding inside the container
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Movie Description',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  10), // Space between title and content
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Text(
                                                itemslist1Urls[index][
                                                    'description']!, // Use description from the imported file
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  20), // Space before the close button
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              child: Text(
                                                'Close',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(right: 1345),
              child: Text(
                'Trending Now',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              height: 350, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    itemlist2Urls.length, // Replace with actual item count
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(0),
                        image: DecorationImage(
                          image: NetworkImage(itemlist2Urls[index]
                              ['url']!), // Use URL from the imported file
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(right: 1345),
              child: Text(
                'New and Hot',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              height: 350, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    itemslist3Urls.length, // Replace with actual item count
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(0),
                        image: DecorationImage(
                          image: NetworkImage(itemslist3Urls[index]
                              ['url']!), // Use URL from the imported file
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(right: 1260),
              child: Text(
                'Creepy and Chilling',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            Container(
              height: 350, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                itemslist4Urls.length, // Replace with actual item count
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(0),
                        image: DecorationImage(
                          image: NetworkImage(itemslist4Urls[index]
                          ['url']!), // Use URL from the imported file
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Add more widgets or sections here
          ],
        ),
      ),
    );
  }
}
