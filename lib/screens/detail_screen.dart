import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class DetailScreen extends StatelessWidget {
  final String imageUrl;
  final String description;

  DetailScreen({required this.imageUrl, required this.description});

  // Function to handle playing the video (placeholder for your actual implementation)
  void _playVideoFullScreen(BuildContext context) {
    // Implement your logic to play the video here
    // This is a placeholder method
    print('Play video');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // Adjust width percentage as needed
              height: MediaQuery.of(context).size.height *
                  0.6, // Adjust image height as needed
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,

                // Cover the entire container
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1270, top: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'The Shining',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Adjust spacing between texts
                    Center(
                      child: Text(
                        'Cast',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    SizedBox(height: 15), // Adjust spacing between texts

                    Center(
                      child: Text(
                        'Jack Nicholson\nShelley Duvall\n'
                        'Danny Lloyd\nScatman Crothers\n'
                        'Philip Stone\nJoe Turkel '
                        '\nBarry Nelson\n Anne Jackson \n Tony Burton \n Lia Beldam',
                        textAlign: TextAlign.center, // Align text to center horizontally

                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          height: 1.7, // Adjust the height factor as needed for spacing

                        ),
                      ),
                    ),
                    SizedBox(height: 25,),
                    Center(
                      child: Text(
                        'Maturity Rating',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        '18+',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // child: Text(

            Padding(
              padding: EdgeInsets.only(left: 1057, top: 388),
              child: ElevatedButton(
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
                      color: Colors.red, // Color of the play icon
                    ),
                    SizedBox(width: 8), // Adjust spacing between icon and text
                    Text(
                      'Trailer',
                      style: TextStyle(
                        color: Colors.black, // Text color of the trailer button
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 30), // Adjust spacing between the texts
                  Text(
                    "Genre: Psychological, Chilling, Scary, Supernatural", // Add your genre text here
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      height:
                          15), // Adjust spacing between the texts and the button
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
