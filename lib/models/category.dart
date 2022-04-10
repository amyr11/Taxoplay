import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taxoplay/helpers/sp_helper.dart';
import 'package:taxoplay/screens/multiple_question_screen.dart';
import 'package:taxoplay/screens/puzzle_screen.dart';

const String histTaxonomy = 'History of Taxonomy';
const String genetics = 'Genetics';
const String classification = 'Classification';

class Difficulty {
  static const String easy = 'Easy';
  static const String average = 'Average';
  static const String difficult = 'Difficult';

  static void forEachDiff(Function(String difficulty) func) {
    for (String difficulty in [
      Difficulty.easy,
      Difficulty.average,
      Difficulty.difficult
    ]) {
      func(difficulty);
    }
  }
}

class Category {
  final String name;
  final Map<String, CategoryRound> _rounds = {};

  Category(this.name, List<Question> easy, List<Question> average,
      List<Question> difficult) {
    _rounds[Difficulty.easy] = CategoryRound(name, Difficulty.easy, easy);
    _rounds[Difficulty.average] =
        CategoryRound(name, Difficulty.average, average);
    _rounds[Difficulty.difficult] =
        CategoryRound(name, Difficulty.difficult, difficult);
  }

  CategoryRound getRound(String difficulty) {
    return _rounds[difficulty]!;
  }

  static void resetBestScores() {
    Difficulty.forEachDiff((difficulty) {
      forEachCat((categoryName) {
        SPHelper.sp.setInt('$categoryName.$difficulty', 0);
      });
    });
  }

  static int getStat(String categoryName) {
    int total = 0;
    Difficulty.forEachDiff((difficulty) {
      total += SPHelper.sp.getInt('$categoryName.$difficulty') ?? 0;
    });
    return total;
  }

  static void forEachCat(Function(String categoryName) func) {
    for (String categoryName in [histTaxonomy, genetics, classification]) {
      func(categoryName);
    }
  }
}

class CategoryRound {
  final String categoryName;
  final String difficulty;
  late final String spString;
  final List<Question> questions;
  bool isComplete = false;
  final String _notCompleteError =
      'This round was scored but was not finished yet.';

  CategoryRound(this.categoryName, this.difficulty, this.questions) {
    spString = '$categoryName.$difficulty';
  }

  void _checkComplete() {
    bool complete = true;
    for (Question question in questions) {
      if (!question.isAnswered) {
        complete = false;
        break;
      }
    }
    isComplete = complete;
    if (isComplete) _saveScore();
  }

  void updateQuestion(int index, Question updated) {
    questions[index] = updated;
    _checkComplete();
  }

  int score() {
    assert(isComplete, _notCompleteError);

    int score = 0;
    for (Question question in questions) {
      score += question.isCorrect ? question.price : 0;
    }
    return score;
  }

  void _saveScore() async {
    assert(isComplete, _notCompleteError);

    int score = this.score();
    int bestScore = SPHelper.sp.getInt(spString) ?? 0;

    if (score > bestScore) {
      SPHelper.sp.setInt(spString, score);
    }
  }
}

abstract class Question {
  final int price;
  final String question;
  final String answer;
  bool isAnswered = false;
  bool isCorrect = false;
  final int time;
  late final bool timed;

  Question(this.price, this.question, this.answer, this.time) {
    timed = time > 0;
  }

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

  PuzzleQuestion(int price, String question, String answer, this.hints,
      {int time = 0})
      : super(price, question, answer, time) {
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
    return PuzzleScreen(
      categoryName: categoryName,
      question: this,
    );
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
      {bool includeNone = false, int time = 0})
      : super(price, question, answer, time) {
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
