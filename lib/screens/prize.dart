import 'package:flutter/material.dart';
import 'package:taxoplay/models/category.dart';

class PrizeScreen extends StatelessWidget {
  final Category category;
  const PrizeScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
    );
  }
}
