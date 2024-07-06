// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:main_screens/mainscreens/SearchPage.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:main_screens/utils/widget_functions.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    required this.size,
    required this.searchHeight,
  });

  final Size size;
  final double searchHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      // Navigate to the search page or execute any other action
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      );
    },
      child: Container(
      width: size.width - 3.5*padding,
      height: searchHeight,
      decoration: BoxDecoration(  
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // border: Border.all(color: colorBlack),
        color: Colors.white, 
      ),
      child: Align(
          // alignment: Alignment.center,
          // color: Colors.red,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                addHorizontalSpace(padding/3), 
                Icon(Icons.search, color: colorBlack.withOpacity(0.7)),
                addHorizontalSpace(padding/3), 
                Text(
                  "Search for people...", 
                  style: TextStyle(
                    fontSize: 18, 
                    color: colorBlack.withOpacity(0.7), 
                    fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
                           ),
      ),
    );
  }
}