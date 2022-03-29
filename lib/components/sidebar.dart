import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';

import '../models/screen.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Expanded(
            child: ListView.builder(
              itemCount: screens.length,
              itemBuilder: (context, index) =>
                  buildListTile(context, screens[index]),
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, Screen screen) {
    return ListTile(
      selectedColor: kSecondaryColor,
      selectedTileColor: Colors.white.withAlpha(20),
      selected: screen.selected,
      title: Text(screen.name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen.screen),
        );
      },
    );
  }
}
