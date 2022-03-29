import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';

import '../models/screen.dart';

class SideBar extends StatelessWidget {
  final int highlighted;

  const SideBar({Key? key, required this.highlighted}) : super(key: key);

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
              itemBuilder: (context, index) => buildListTile(context, index),
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, int index) {
    Screen screen = screens[index];

    return ListTile(
      selectedColor: kSecondaryColor,
      selectedTileColor: Colors.white.withAlpha(20),
      selected: highlighted == index,
      title: Text(screen.name),
      onTap: () {
        Navigator.push(
          context,
          // MaterialPageRoute(builder: (context) => screen.screen),
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => screen.screen,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 150),
          ),
        );
      },
    );
  }
}
