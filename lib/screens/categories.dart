import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/screens/prize_screens/classification.dart';
import 'package:taxoplay/screens/prize_screens/genetics.dart';
import 'package:taxoplay/screens/prize_screens/hist_taxonomy.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
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
              'Pick a Category',
              style: TextStyle(
                fontSize: 24,
                color: kSecondaryColor,
              ),
            ),
            vSpace(kDefaultSpace),
            buildCatButton(
              'History of Taxonomy',
              context,
              const HistTaxonomyScreen(),
            ),
            vSpace(kDefaultSpace / 2),
            // buildCatButton('Genetics'),
            buildCatButton(
              'Genetics',
              context,
              const GeneticsScreen(),
            ),
            vSpace(kDefaultSpace / 2),
            // buildCatButton('Classification'),
            buildCatButton(
              'Classification',
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
        Navigator.push(
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
