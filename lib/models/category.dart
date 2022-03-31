class Category {
  Category(String name, List<Question> easy, List<Question> average,
      List<Question> difficult);
}

abstract class Question {
  Question(int price, String question, String answer);

  bool isCorrect(String answer);
  void goToScreen();
}

class PuzzleQuestion extends Question {
  PuzzleQuestion(int price, String question, String answer, List<int> hints)
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
  MultipleChoiceQuestion(
      int price, String question, String answer, List<String> wrongAnswers)
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