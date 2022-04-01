import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/models/category.dart';

class MultipleQuestionScreen extends StatefulWidget {
  final Question question;

  const MultipleQuestionScreen({Key? key, required this.question})
      : super(key: key);

  @override
  State<MultipleQuestionScreen> createState() => _MultipleQuestionScreenState();
}

class _MultipleQuestionScreenState extends State<MultipleQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultButton(
        onPressed: () {
          Navigator.pop(context, false);
        },
        text: 'Back',
      ),
    );
  }
}
