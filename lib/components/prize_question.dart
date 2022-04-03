import 'package:flutter/material.dart';
import 'package:taxoplay/helpers/empty_space.dart';

import '../constants.dart';
import '../models/category.dart';

class PrizeAndQuestion extends StatelessWidget {
  const PrizeAndQuestion({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '\$${question.price}',
          style: const TextStyle(fontSize: 34),
        ),
        vSpace(kDefaultSpace / 2),
        Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultSpace / 3),
          child: Text(
            question.question,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kSecondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
