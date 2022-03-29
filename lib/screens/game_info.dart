import 'package:flutter/material.dart';

import '../components/sidebar.dart';

class GameInfoScreen extends StatelessWidget {
  const GameInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Info"),
      ),
      drawer: const SideBar(),
    );
  }
}
