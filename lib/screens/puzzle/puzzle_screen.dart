import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/models/category.dart';
import 'package:taxoplay/screens/prize_screens/hist_taxonomy.dart';

class PuzzleScreen extends StatefulWidget {
  final String categoryName;
  final Question question;

  const PuzzleScreen(
      {Key? key, required this.categoryName, required this.question})
      : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(categoryName),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);
          return false;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\$${widget.question.price}',
                style: const TextStyle(fontSize: 34),
              ),
              vSpace(kDefaultSpace / 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultSpace / 3),
                child: Text(
                  widget.question.question,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
