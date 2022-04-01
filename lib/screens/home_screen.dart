import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/screens/categories.dart';

import '../../components/buttons.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              width: 250,
              image: AssetImage('assets/logo/logo.png'),
            ),
            vSpace(kDefaultSpace),
            DefaultButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoriesScreen(),
                  ),
                );
              },
              text: 'Start',
            ),
            vSpace(kDefaultSpace),
          ],
        ),
      ),
    );
  }
}
