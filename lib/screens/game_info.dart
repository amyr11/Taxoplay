import 'package:flutter/material.dart';

import '../components/sidebar.dart';

class GameInfoScreen extends StatelessWidget {
  final int id;
  const GameInfoScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Info"),
      ),
      drawer: SideBar(highlighted: id),
    );
  }
}
