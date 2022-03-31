import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
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
            buildCatButton('History of Taxonomy'),
            vSpace(kDefaultSpace / 2),
            buildCatButton('Genetics'),
            vSpace(kDefaultSpace / 2),
            buildCatButton('Classification'),
            vSpace(kDefaultSpace),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildCatButton(String text) {
    return ElevatedButton(
      onPressed: () {},
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
