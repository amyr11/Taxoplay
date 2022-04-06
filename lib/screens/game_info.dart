import 'package:flutter/material.dart';

import '../components/logo_with_text.dart';
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
      body: const LogoWithText(
        header: 'What is Taxoplay?',
        body:
            'TaxoPlay is a game that will guide you to the world of Taxonomy. This game is divided into three specific categories: History of Taxonomy, Genetics and Classifications.',
      ),
    );
  }
}
