import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/screens/categories_screens.dart';

import '../models/category.dart';

class DifficultiesScreen extends StatelessWidget {
  const DifficultiesScreen({Key? key, required this.category})
      : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 145,
              image: AssetImage('assets/logo/logo.png'),
            ),
            vSpace(kDefaultSpace / 2),
            Text(
              'Choose Difficulty',
              style: k24RegularSecondary,
            ),
            vSpace(kDefaultSpace),
            buildCatButton(
              'Easy',
              context,
              const HistTaxonomyScreen(),
            ),
            vSpace(kDefaultSpace / 2),
            // buildCatButton('Genetics'),
            buildCatButton(
              'Average',
              context,
              const GeneticsScreen(),
            ),
            vSpace(kDefaultSpace / 2),
            // buildCatButton('Classification'),
            buildCatButton(
              'Difficult',
              context,
              const ClassificationScreen(),
            ),
            vSpace(kDefaultSpace),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildCatButton(
      String text, BuildContext context, Widget destination) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => destination),
          ),
        );
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(330, 60),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
