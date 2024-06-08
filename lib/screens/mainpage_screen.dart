import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/widgets/movie_content.dart';
import 'package:video_player/video_player.dart';

import 'detail_screen.dart';
import 'trailer_screen.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isAudioOn = true;
  bool isHover = false;
  int _currentCarouselIndex = 0;
  //
  //
  // final List<String> videoUrls = [
  //   'assets/videos/dune3video.mp4',
  //   'assets/videos/dune3video.mp4',
  // ];

  // Track the state of audio (on/off)

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
      // appBar: AppBar(
      //   title: Text('Your App Title'), // Replace with your app title
      //   backgroundColor: Colors.black, // Customize app bar background color
      //   // You can customize further properties of the AppBar here
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(
                                  height: 10), // Adjust the height as needed
                              Text(
                                'In a universe rife with intrigue and betrayal, '
                                'a young leader rallies a band of rebels '
                                'against \nthose who destroyed his family. '
                                'Faced with an impossible choice between love '
                                'and the fate \nof humanity, '
                                'he must unlock the secrets of a dark prophecy to '
                                'avert a catastrophic \nfuture.',
                                // Replace with your text
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Montserrat',
                                ),
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
                  bool isHovering = false; // Track hover state for each item
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              isHovering = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              isHovering = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    title : itemslist1Urls[index]['title']!,
                                    imageUrl: itemslist1Urls[index]['url2']!,
                                    description: itemslist1Urls[index]
                                        ['description']!,
                                    genre : itemslist1Urls[index]['genre']!,
                                    cast : itemslist1Urls[index]['cast']!,
                                    videoId: itemslist1Urls[index]['videoId']!, // Pass the videoId

                                  ),
                                ),
                              );
                              _videoPlayerController.pause();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    transform: isHovering
                                        ? (Matrix4.identity()
                                          ..setEntry(
                                              3, 2, 0.001) // Add perspective
                                          ..rotateX(0.0)
                                          ..rotateY(0.0)
                                          ..scale(1.1))
                                        : Matrix4.identity(),
                                    child: Material(
                                      elevation: isHovering
                                          ? 20
                                          : 0, // Apply elevation when hovering
                                      child: Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          image: DecorationImage(
                                            image: NetworkImage(itemslist1Urls[
                                                    index][
                                                'url']!), // Use URL from the imported file
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (isHovering)
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Text(
                                        '',
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ));
                    },
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
              height: 330, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemlist2Urls.length, // Use the imported list
                itemBuilder: (context, index) {
                  bool isHovering = false; // Track hover state for each item
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              isHovering = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              isHovering = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    title : itemlist2Urls[index]['title']!,
                                    imageUrl: itemlist2Urls[index]['url2']!,
                                    description: itemlist2Urls[index]
                                    ['description']!,
                                    genre : itemlist2Urls[index]['genre']!,
                                    cast : itemlist2Urls[index]['cast']!,
                                    videoId: itemlist2Urls[index]['videoId']!, // Pass the videoId


                                  ),
                                ),
                              );
                              _videoPlayerController.pause();
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    transform: isHovering
                                        ? (Matrix4.identity()
                                      ..setEntry(
                                          3, 2, 0.001) // Add perspective
                                      ..rotateX(0.0)
                                      ..rotateY(0.0)
                                      ..scale(1.1))
                                        : Matrix4.identity(),
                                    child: Material(
                                      elevation: isHovering
                                          ? 20
                                          : 0, // Apply elevation when hovering
                                      child: Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          image: DecorationImage(
                                            image: NetworkImage(itemlist2Urls[
                                            index][
                                            'url']!), // Use URL from the imported file
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (isHovering)
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Text(
                                        '',
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ));
                    },
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
              height: 330, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemslist3Urls.length, // Use the imported list
                itemBuilder: (context, index) {
                  bool isHovering = false; // Track hover state for each item
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              isHovering = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              isHovering = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    title : itemslist3Urls[index]['title']!,
                                    imageUrl: itemslist3Urls[index]['url2']!,
                                    description: itemslist3Urls[index]
                                    ['description']!,
                                    genre : itemslist3Urls[index]['genre']!,
                                    cast : itemslist3Urls[index]['cast']!,
                                    videoId: itemslist3Urls[index]['videoId']!, // Pass the videoId

                                  ),
                                ),
                              );
                              _videoPlayerController.pause();
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    transform: isHovering
                                        ? (Matrix4.identity()
                                      ..setEntry(
                                          3, 2, 0.001) // Add perspective
                                      ..rotateX(0.0)
                                      ..rotateY(0.0)
                                      ..scale(1.1))
                                        : Matrix4.identity(),
                                    child: Material(
                                      elevation: isHovering
                                          ? 20
                                          : 0, // Apply elevation when hovering
                                      child: Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          image: DecorationImage(
                                            image: NetworkImage(itemslist3Urls[
                                            index][
                                            'url']!), // Use URL from the imported file
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (isHovering)
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Text(
                                        '',
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ));
                    },
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
              height: 330, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemslist4Urls.length, // Use the imported list
                itemBuilder: (context, index) {
                  bool isHovering = false; // Track hover state for each item
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              isHovering = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              isHovering = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    title : itemslist4Urls[index]['title']!,
                                    imageUrl: itemslist4Urls[index]['url2']!,
                                    description: itemslist4Urls[index]
                                    ['description']!,
                                    genre : itemslist4Urls[index]['genre']!,
                                    cast : itemslist4Urls[index]['cast']!,
                                    videoId: itemslist4Urls[index]['videoId']!, // Pass the videoId

                                  ),
                                ),
                              );
                              _videoPlayerController.pause();
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    transform: isHovering
                                        ? (Matrix4.identity()
                                      ..setEntry(
                                          3, 2, 0.001) // Add perspective
                                      ..rotateX(0.0)
                                      ..rotateY(0.0)
                                      ..scale(1.1))
                                        : Matrix4.identity(),
                                    child: Material(
                                      elevation: isHovering
                                          ? 20
                                          : 0, // Apply elevation when hovering
                                      child: Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                          BorderRadius.circular(0),
                                          image: DecorationImage(
                                            image: NetworkImage(itemslist4Urls[
                                            index][
                                            'url']!), // Use URL from the imported file
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (isHovering)
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Text(
                                        '',
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ));
                    },
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
