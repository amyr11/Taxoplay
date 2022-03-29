import 'package:flutter/material.dart';

import '../components/sidebar.dart';

class GameInstructionScreen extends StatelessWidget {
  const GameInstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Instruction"),
      ),
      drawer: const SideBar(),
    );
  }
}
