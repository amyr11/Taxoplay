import 'package:flutter/material.dart';

import '../components/sidebar.dart';

class StatsSceen extends StatelessWidget {
  final int id;
  const StatsSceen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats"),
      ),
      drawer: SideBar(highlighted: id),
    );
  }
}
