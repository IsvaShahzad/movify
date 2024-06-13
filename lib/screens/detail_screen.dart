import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/detailscreen_content.dart';

class DetailScreen extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String genre;
  final String title;
  final String cast;
  final String videoId;

  DetailScreen({
    required this.imageUrl,
    required this.description,
    required this.genre,
    required this.title,
    required this.cast,
    required this.videoId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DetailContent(
        imageUrl: imageUrl,
        description: description,
        genre: genre,
        title: title,
        cast: cast,
        videoId: videoId,
      ),
    );
  }
}
