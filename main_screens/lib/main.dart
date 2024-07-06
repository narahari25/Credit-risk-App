// ignore_for_file: prefer_const_constructors
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:main_screens/custom/People.dart';
import 'package:main_screens/mainscreens/HomePage.dart';
import 'package:main_screens/mainscreens/LoginPage.dart';
import 'package:main_screens/mainscreens/RequestCreditPage.dart';
import 'package:main_screens/mainscreens/SecondProfile.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:main_screens/mainscreens/RequestCreditPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter bindings are initialized

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp()); // Run your Flutter application
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: colorBackground),
      title: "first few screens",
      //me defined in People.dart
      home: LoginPage(),
      // routes: {
      //   '/mainprofile': (context) => MyProfile(me: me),
      //   '/homepage': (context) => HomePage(me: me,),
      // },
      // theme: ,
    );
  } 
}

