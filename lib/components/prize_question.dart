import 'package:flutter/material.dart';

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
        Container(
          padding: EdgeInsets.only(top: kDefaultSpace / 2),
          child: Text(
            '\$${question.price}',
            style: const TextStyle(fontSize: 34),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultSpace / 3,
            vertical: kDefaultSpace / 2,
          ),
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
