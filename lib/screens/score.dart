import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Text(
            '\$$score',
          ),
        ],
      ),
    );
  }
}
