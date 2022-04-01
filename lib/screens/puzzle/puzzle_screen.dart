import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
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
        child: Column(),
      ),
    );
  }
}
