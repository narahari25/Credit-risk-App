// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:main_screens/utils/widget_functions.dart';

// ignore: must_be_immutable
class SettingOption extends StatelessWidget {
  SettingOption({
    super.key,
    required this.padding,
    required this.circularButton, required this.value, required this.type, required this.icon
  });

  final double padding;
  final bool circularButton;
  // ignore: prefer_typing_uninitialized_variables
  var value; 
  final String type;
  final Icon icon; 
  // final Color backColor; 


  @override
  Widget build(BuildContext context) {
    var backColor = colorBlack;
    if (value == 0)
    {
      value = "Aadhar";
    }
    else if(value == 1)
    {
      value = "Pan";
    }

    if (circularButton) {
      backColor = Color.fromRGBO(226, 227, 216, 1); 
    } else {
      backColor = colorBlack.withOpacity(0); 
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
      child: Row(
        children: [
          Stack(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backColor 
                ),
              ),
              Positioned.fill(
                child: Align(
                    child: icon
                )
              ),
            ],
          ),
          addHorizontalSpace(padding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text(type, style: TextStyle(fontSize: 16),),
            ],
          ),
        ],
      ),
    );
  }
}