import 'package:flutter/material.dart';

import '../components/sidebar.dart';

class DevelopersScreen extends StatelessWidget {
  final int id;
  const DevelopersScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Developers"),
      ),
      drawer: SideBar(highlighted: id),
    );
  }
}
