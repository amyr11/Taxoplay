import 'package:flutter/material.dart';

import '../components/sidebar.dart';

class GameInstructionScreen extends StatelessWidget {
  final int id;
  const GameInstructionScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Instruction"),
      ),
      drawer: SideBar(highlighted: id),
    );
  }
}
