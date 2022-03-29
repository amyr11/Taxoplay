import 'package:flutter/material.dart';

import '../../components/sidebar.dart';

class HomeScreen extends StatelessWidget {
  final int id;
  const HomeScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: SideBar(highlighted: id),
      body: Column(
        children: const [
          Image(
            image: AssetImage('assets/logo/logo.png'),
          ),
        ],
      ),
    );
  }
}
