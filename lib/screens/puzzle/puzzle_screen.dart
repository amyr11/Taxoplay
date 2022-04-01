import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/models/category.dart';

class PuzzleScreen extends StatefulWidget {
  final Question question;

  const PuzzleScreen({Key? key, required this.question}) : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        text: 'Back',
      ),
    );
  }
}
