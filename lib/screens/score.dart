import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/screens/categories.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen(this.categoryName, this.score, {Key? key})
      : super(key: key);

  final String categoryName;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You Earned',
                    style: k24RegularWhite,
                  ),
                  vSpace(kDefaultSpace / 2),
                  Text(
                    '\$$score',
                    style: k50BoldSecondary,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Congratulations!',
                      style: k24RegularSecondary,
                    ),
                    vSpace(kDefaultSpace / 4),
                    Text(
                      'Try the other categories to test your knowledge on different topics.',
                      style: k16RegularWhite,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: DefaultButton(
                text: 'Play Again',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesScreen(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
