import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxoplay',
      theme: kDarkTheme,
      // theme: ThemeData(brightness: Brightness.light),
      home: const HomeScreen(id: 0),
    );
  }
}
