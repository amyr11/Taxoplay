import 'package:flutter/material.dart';
import 'package:taxoplay/components/prize_screen.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/screens/categories.dart';

import '../models/category.dart';

class DifficultiesScreen extends StatelessWidget {
  const DifficultiesScreen({Key? key, required this.category})
      : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => const CategoriesScreen())));
        return false;
      },
      child: Scaffold(
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
              buildDiffButton(
                'Easy',
                context,
                PrizeScreen(
                  categoryName: category.name,
                  round: category.getRound(Difficulty.easy),
                ),
              ),
              vSpace(kDefaultSpace / 2),
              // buildCatButton('Genetics'),
              buildDiffButton(
                'Average',
                context,
                PrizeScreen(
                  categoryName: category.name,
                  round: category.getRound(Difficulty.average),
                ),
              ),
              vSpace(kDefaultSpace / 2),
              // buildCatButton('Classification'),
              buildDiffButton(
                'Difficult',
                context,
                PrizeScreen(
                  categoryName: category.name,
                  round: category.getRound(Difficulty.difficult),
                ),
              ),
              vSpace(kDefaultSpace),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildDiffButton(
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
