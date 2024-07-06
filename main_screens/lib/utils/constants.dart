import 'package:flutter/material.dart';



const colorBlack = Color.fromRGBO(48, 47, 48, 1.0);
const colorGrey = Color.fromRGBO(141, 141, 141, 1.0);

const colorWhite = Colors.white;
// const colorDarkBlue = Color.fromRGBO(20, 25, 45, 1.0);

const colorBackground = Color.fromRGBO(237, 239, 227, 1.0);
const colorGreen = Color.fromRGBO(219, 234, 141, 1.0);

const double titleFontSize = 25;
const double padding = 25;



// const ThemeData materialThemeDefault = ThemeData(

// )
const TextTheme textThemeDefault = TextTheme(
    displayLarge: TextStyle(
        color: colorBlack, fontWeight: FontWeight.w700, fontSize: 26),
    displayMedium: TextStyle(
        color: colorBlack, fontWeight: FontWeight.w700, fontSize: 22),
    displaySmall: TextStyle(
        color: colorBlack, fontWeight: FontWeight.w700, fontSize: 20),
    headlineMedium: TextStyle(
        color: colorBlack, fontWeight: FontWeight.w700, fontSize: 16),
    headlineSmall: TextStyle(
        color: colorBlack, fontWeight: FontWeight.w700, fontSize: 14),
    titleLarge: TextStyle(
        color: colorBlack, fontWeight: FontWeight.w700, fontSize: 12),
    bodyLarge: TextStyle(
        color: colorBlack, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    bodyMedium: TextStyle(
        color:  colorGrey, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    titleMedium:
        TextStyle(color: colorBlack, fontSize: 12, fontWeight: FontWeight.w400),
    titleSmall: TextStyle(
        color: colorGrey, fontSize: 12, fontWeight: FontWeight.w400));