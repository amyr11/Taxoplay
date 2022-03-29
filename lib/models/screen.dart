import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class Screen {
  final String name;
  final Widget screen;
  final bool selected = false;

  Screen(this.name, this.screen);

  set selected(bool isSelected) {
    selected = isSelected;
  }
}

List<Screen> screens = [
  Screen('Home', const HomeScreen()),
];
