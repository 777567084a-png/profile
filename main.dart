import  'package:flutter/material.dart';
import 'package:untitled13/LoginScreen.dart';
import 'package:flutter/widgets.dart';
import 'spashscreen.dart';
import 'LoginScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final String username;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: spashscreen(),
    );
  }
}



