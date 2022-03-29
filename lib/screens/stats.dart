import 'package:flutter/material.dart';

import '../components/sidebar.dart';

class StatsSceen extends StatelessWidget {
  const StatsSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats"),
      ),
      drawer: const SideBar(),
    );
  }
}
