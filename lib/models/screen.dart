import 'package:flutter/material.dart';
import 'package:taxoplay/screens/Stats.dart';
import 'package:taxoplay/screens/developers.dart';
import 'package:taxoplay/screens/game_info.dart';
import 'package:taxoplay/screens/game_instruction.dart';

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
  Screen('Stats', const StatsSceen()),
  Screen('Game Info', const GameInfoScreen()),
  Screen('Game Instruction', const GameInstructionScreen()),
  Screen('Developers', const DevelopersScreen()),
];
