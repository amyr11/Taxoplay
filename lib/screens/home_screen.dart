import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/models/screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: const SideBar(),
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SafeArea(
            child: SizedBox(
              height: 65,
              child: DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          buildListTile(context),
          ListTile(
            title: const Text('Stats'),
            onTap: () {
              //...
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Game Info'),
            onTap: () {
              //...
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Game Instruction'),
            onTap: () {
              //...
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Developers'),
            onTap: () {
              //...
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context) {
    return ListTile(
      selectedColor: kSecondaryColor,
      selectedTileColor: Colors.white.withAlpha(20),
      selected: true,
      title: const Text('Home'),
      onTap: () {
        //...
        Navigator.pop(context);
      },
    );
  }
}
