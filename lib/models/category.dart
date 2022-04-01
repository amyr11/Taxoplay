import 'package:flutter/material.dart';
import 'package:taxoplay/screens/multiple_question/multiple_question_screen.dart';
import 'package:taxoplay/screens/puzzle/puzzle_screen.dart';

class Category {
  final String name;
  final List<Question> easy;
  final List<Question> average;
  final List<Question> difficult;

  Category(this.name, this.easy, this.average, this.difficult);
}

abstract class Question {
  final int price;
  final String question;
  final String answer;
  bool isAnswered = false;
  bool isCorrect = false;

  Question(this.price, this.question, this.answer);

  Widget getScreen();

  void setAnswered(bool isCorrect) {
    isAnswered = true;
    this.isCorrect = isCorrect;
  }
}

class PuzzleQuestion extends Question {
  final List<int> hints;
  PuzzleQuestion(int price, String question, String answer, this.hints)
      : super(price, question, answer);

  @override
  Widget getScreen() {
    return PuzzleScreen(question: this);
  }
}

class MultipleChoiceQuestion extends Question {
  final List<String> wrongAnswers;

  MultipleChoiceQuestion(
      int price, String question, String answer, this.wrongAnswers)
      : super(price, question, answer);

  @override
  Widget getScreen() {
    return MultipleQuestionScreen(question: this);
  }
}

/*
- Category
  - name // string
  - easy // Array of Questions
  - average // Array of Questions
  - difficult // Array of Questions

- Question
  - price // int
  - question // string
  - answer // string
  
  - isCorrect(answer, correct) // bool method
  - goToScreen() // abstract method

  - PuzzleQuestion
    - hints // Array of indices in answer to show
  - MultipleChoiceQuestion
    - choices // array of strings
*/