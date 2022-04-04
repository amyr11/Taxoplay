import 'dart:math';

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
  final bool timed;

  Question(this.price, this.question, this.answer, {this.timed = false});

  Widget getScreen(String categoryName);

  void checkAnswer() {
    isAnswered = true;
  }

  bool isDone();
}

const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

class PuzzleQuestion extends Question {
  final List<int> hints;
  List<PuzzleChar> puzzleChars = [];
  List<String> puzzleChoices = [];

  PuzzleQuestion(int price, String question, String answer, this.hints)
      : super(price, question, answer) {
    List<String> splitAnswer = answer.split('').toList();
    for (int i = 0; i < splitAnswer.length; i++) {
      bool isHint = hints.contains(i);
      String correctValue = answer[i];
      String? currentValue = isHint ? correctValue : null;
      int? currentIndex = isHint ? -1 : null;

      puzzleChars
          .add(PuzzleChar(currentValue, currentIndex, correctValue, isHint));
    }
    puzzleChoices.addAll(splitAnswer);
    for (int i = puzzleChoices.length; i < 16; i++) {
      puzzleChoices.add(alphabet[Random().nextInt(alphabet.length)]);
    }
    puzzleChoices.shuffle();
  }

  @override
  Widget getScreen(String categoryName) {
    return PuzzleScreen(categoryName: categoryName, question: this);
  }

  @override
  bool isDone() {
    // Find puzzleChars with empty currentIndex
    List<PuzzleChar> emptyChars =
        puzzleChars.where((element) => element.currentIndex == null).toList();
    return emptyChars.isEmpty;
  }

  @override
  void checkAnswer() {
    super.checkAnswer();
    for (PuzzleChar char in puzzleChars) {
      if (!char.evaluate()) {
        return;
      }
    }
    isCorrect = true;
  }
}

class PuzzleChar {
  String? currentValue;
  int? currentIndex;
  String correctValue;
  bool isHint;

  PuzzleChar(
      this.currentValue, this.currentIndex, this.correctValue, this.isHint);

  void clearValue() {
    currentValue = null;
    currentIndex = null;
  }

  bool evaluate() {
    return currentValue == correctValue;
  }
}

class MultipleChoiceQuestion extends Question {
  final List<String> wrongAnswers;
  final List<String> _choices = [];
  String? currentAnswer;

  get choices => _choices;

  MultipleChoiceQuestion(
      int price, String question, String answer, this.wrongAnswers,
      {bool includeNone = false, bool timed = false})
      : super(price, question, answer, timed: timed) {
    _choices.add(answer);
    _choices.addAll(wrongAnswers);
    _choices.shuffle();

    if (includeNone) {
      _choices.add('None of the above');
    }
  }

  @override
  Widget getScreen(String categoryName) {
    return MultipleQuestionScreen(
      categoryName: categoryName,
      question: this,
      timed: timed,
    );
  }

  @override
  void checkAnswer() {
    super.checkAnswer();
    isCorrect = currentAnswer == answer;
  }

  @override
  bool isDone() {
    return currentAnswer != null;
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