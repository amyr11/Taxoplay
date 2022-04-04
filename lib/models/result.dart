import 'package:taxoplay/models/category.dart';

class Result {
  final Question updatedQuestion;
  final bool timeRanOut;
  Result(this.updatedQuestion, {this.timeRanOut = false});
}
