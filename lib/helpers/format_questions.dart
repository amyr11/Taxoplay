import 'package:taxoplay/models/category.dart';

List<Question> easy = [
  PuzzleQuestion(
    100,
    "question",
    "answer",
    [1, 0],
  ),
  MultipleChoiceQuestion(
    100,
    "question",
    "answer",
    ["wrong1", "wrong2", "wrong3"],
  ),
  MultipleChoiceQuestion(
    100,
    "question",
    "answer",
    ["wrong1", "wrong2"],
    includeNone: true,
  ),
];

List<Question> average = [
  MultipleChoiceQuestion(
    100,
    "question",
    "answer",
    ["wrong1", "wrong2", "wrong3"],
  ),
  MultipleChoiceQuestion(
    100,
    "question",
    "answer",
    ["wrong1", "wrong2"],
    includeNone: true,
  ),
];

List<Question> difficult = [
  PuzzleQuestion(100, "question", "answer", [1, 0], time: 60),
  MultipleChoiceQuestion(
    100,
    "question",
    "answer",
    ["wrong1", "wrong2", "wrong3"],
    time: 60,
  ),
  MultipleChoiceQuestion(
    100,
    "question",
    "answer",
    ["wrong1", "wrong2"],
    includeNone: true,
    time: 60,
  ),
];
