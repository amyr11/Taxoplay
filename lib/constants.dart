import 'package:flutter/material.dart';

Color kPrimaryColor = const Color.fromARGB(255, 49, 59, 123);
Color kSecondaryColor = const Color.fromARGB(255, 255, 189, 89);
Color kBackgroundColor = const Color.fromARGB(255, 22, 29, 68);
Color kButtonColor = const Color.fromARGB(255, 13, 19, 52);

ThemeData kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kBackgroundColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(kButtonColor),
      foregroundColor: MaterialStateProperty.all<Color>(kSecondaryColor),
    ),
  ),
);
