import 'package:flutter/material.dart';

import '../components/sidebar.dart';

class DevelopersScreen extends StatelessWidget {
  const DevelopersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Developers"),
      ),
      drawer: const SideBar(),
    );
  }
}
