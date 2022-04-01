import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/models/category.dart';

class PrizeScreen extends StatelessWidget {
  final Category category;
  const PrizeScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // vSpace(kDefaultSpace),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 30,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              vSpace(kDefaultSpace),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    child: CategoryCard(category: 'Easy'),
                  ),
                  Expanded(
                    child: CategoryCard(category: 'Average'),
                  ),
                  Expanded(
                    child: CategoryCard(category: 'Difficult'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        PrizeCard(question: category.easy[0]),
                        PrizeCard(question: category.easy[1]),
                        PrizeCard(question: category.easy[2]),
                        PrizeCard(question: category.easy[3]),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        PrizeCard(question: category.average[0]),
                        PrizeCard(question: category.average[1]),
                        PrizeCard(question: category.average[2]),
                        PrizeCard(question: category.average[3]),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        PrizeCard(question: category.difficult[0]),
                        PrizeCard(question: category.difficult[1]),
                        PrizeCard(question: category.difficult[2]),
                        PrizeCard(question: category.difficult[3]),
                      ],
                    ),
                  ),
                ],
              ),
              vSpace(kDefaultSpace),
              DefaultButton(onPressed: () {}, text: 'Show Score'),
              vSpace(kDefaultSpace),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;

  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 7,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kPrimaryColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              category,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class PrizeCard extends StatelessWidget {
  final Question question;

  const PrizeCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 7,
      ),
      child: InkWell(
        onTap: () {
          question.goToScreen();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 2,
              color: kPrimaryLightColor,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                '\$${question.price}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
