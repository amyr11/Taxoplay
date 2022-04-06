import 'package:flutter/material.dart';
import 'package:taxoplay/screens/Stats.dart';
import 'package:taxoplay/screens/developers.dart';
import 'package:taxoplay/screens/game_info.dart';
import 'package:taxoplay/screens/game_instruction.dart';

import '../screens/home_screen.dart';

class Screen {
  String name;
  Widget screen;

  Screen(this.name, this.screen);
}

List<Screen> screens = [
  Screen('Home', const HomeScreen(id: 0)),
  Screen('Stats', const StatsSceen(id: 1)),
  Screen('Game Info', const GameInfoScreen(id: 2)),
  Screen('Game Instruction', GameInstructionScreen(id: 3)),
  Screen('Developers', const DevelopersScreen(id: 4)),
];
