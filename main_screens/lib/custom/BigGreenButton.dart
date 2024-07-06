import 'package:flutter/material.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:main_screens/utils/widget_functions.dart';

class BigGreenButton extends StatelessWidget {
  const BigGreenButton({
    super.key,
    required this.padding, required this.text, required this.icon, required this.widget
  });

  final double padding;
  final String text;
  final Icon icon; 
  final Widget widget; 

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.fromLTRB(padding, 30, padding, 30),
        // foregroundColor: Mat erialStateProperty.all<Color>(Colors.blue),
        backgroundColor: const Color.fromRGBO(219, 234, 141, 1),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
  );
      },
      child: Align(
        // alignment: Alignment.center,
        // color: Colors.red,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            addHorizontalSpace(padding/3), 
            Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorBlack),),
          ],
        ),
      ),
    );
  }
}

