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

  Question(this.price, this.question, this.answer);

  bool isCorrect(String answer);
  void goToScreen();
}

class PuzzleQuestion extends Question {
  final List<int> hints;
  PuzzleQuestion(int price, String question, String answer, this.hints)
      : super(price, question, answer);

  @override
  void goToScreen() {
    // TODO: implement goToScreen
  }

  @override
  bool isCorrect(String answer) {
    // TODO: implement isCorrect
    throw UnimplementedError();
  }
}

class MultipleChoiceQuestion extends Question {
  final List<String> wrongAnswers;

  MultipleChoiceQuestion(
      int price, String question, String answer, this.wrongAnswers)
      : super(price, question, answer);

  @override
  void goToScreen() {
    // TODO: implement goToScreen
  }

  @override
  bool isCorrect(String answer) {
    // TODO: implement isCorrect
    throw UnimplementedError();
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