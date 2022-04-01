import 'package:flutter/material.dart';

// Colors
Color kPrimaryColor = const Color.fromARGB(255, 49, 59, 123);
Color kPrimaryLightColor = const Color.fromARGB(255, 104, 119, 219);
Color kSecondaryColor = const Color.fromARGB(255, 255, 189, 89);
Color kBackgroundColor = const Color.fromARGB(255, 22, 29, 68);
Color kButtonColor = const Color.fromARGB(255, 13, 19, 52);

// Metrics
double kDefaultSpace = 50.0;

ThemeData kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Roboto',
  canvasColor: kPrimaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: kPrimaryColor,
    centerTitle: false,
  ),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
  ),
  scaffoldBackgroundColor: kBackgroundColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(
        const Size(180, 60),
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
      backgroundColor: MaterialStateProperty.all<Color>(kButtonColor),
      foregroundColor: MaterialStateProperty.all<Color>(kSecondaryColor),
    ),
  ),
);
