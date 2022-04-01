import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/models/category.dart';
import 'package:taxoplay/screens/prize_screens/hist_taxonomy.dart';

class MultipleQuestionScreen extends StatefulWidget {
  final String categoryName;
  final Question question;

  const MultipleQuestionScreen(
      {Key? key, required this.categoryName, required this.question})
      : super(key: key);

  @override
  State<MultipleQuestionScreen> createState() => _MultipleQuestionScreenState();
}

class _MultipleQuestionScreenState extends State<MultipleQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(categoryName),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return false;
        },
        child: Column(),
      ),
    );
  }
}
