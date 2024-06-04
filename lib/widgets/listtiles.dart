// list_tile.dart
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String itemslist1Urls;

  const CustomListTile({required this.itemslist1Urls});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(0),
        image: DecorationImage(
          image: NetworkImage(itemslist1Urls),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}