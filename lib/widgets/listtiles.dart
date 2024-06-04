// import 'package:flutter/material.dart';
// import 'package:hello/widgets/image_urls.dart'; // Assuming the image URLs are in this file
//
// Widget topPicksList() {
//   return Container(
//     height: 330, // Adjust the height as needed
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: itemslist1Urls.length, // Use the imported list
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Stack(
//             children: [
//               Container(
//                 width: 250,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(0),
//                   image: DecorationImage(
//                     image: NetworkImage(itemslist1Urls[index]
//                         ['url']!), // Use URL from the imported file
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: IconButton(
//                   icon: Icon(Icons.add, color: Colors.white),
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Dialog(
//                           backgroundColor: Colors
//                               .transparent, // Make the dialog background transparent
//                           child: Container(
//                             width: 300,
//                             height: 300,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.withOpacity(
//                                   0.2), // Semi-transparent background
//                               border: Border.all(
//                                   color: Colors.white,
//                                   width: 2), // White border
//                             ),
//                             padding: EdgeInsets.all(
//                                 20), // Padding inside the container
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Movie Description',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                     height:
//                                         10), // Space between title and content
//                                 Expanded(
//                                   child: SingleChildScrollView(
//                                     child: Text(
//                                       itemslist1Urls[index][
//                                           'description']!, // Use description from the imported file
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                     height:
//                                         20), // Space before the close button
//                                 Align(
//                                   alignment: Alignment.centerRight,
//                                   child: TextButton(
//                                     child: Text(
//                                       'Close',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }
//
// Widget trendingNowList() {
//   return Container(
//     height: 350,
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: itemlist2Urls.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Container(
//             width: 250,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(0),
//               image: DecorationImage(
//                 image: NetworkImage(itemlist2Urls[index]['url']!),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }
//
// Widget newAndHotList() {
//   return Container(
//     height: 350,
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: itemslist3Urls.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Container(
//             width: 250,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(0),
//               image: DecorationImage(
//                 image: NetworkImage(itemslist3Urls[index]['url']!),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }
