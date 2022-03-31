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

Category histTaxonomy = Category(
  'History of Taxonomy',
  [
    PuzzleQuestion(
      100,
      'Greek Philosopher who saw the hierarchy of organisms called the “Ladder of Nature',
      'ARISTOTLE',
      [2, 4, 8],
    ),
    PuzzleQuestion(
      100,
      'One of the three major domains',
      'EUKARYA',
      [0, 2, 6],
    ),
    PuzzleQuestion(
      200,
      'Animals with bony backbones',
      'VERTEBRATES',
      [0, 2, 6, 10],
    ),
    PuzzleQuestion(
      200,
      'Smallest category in the hierarchical classification of organisms',
      'SPECIES',
      [0, 1, 6],
    ),
  ],
  [
    MultipleChoiceQuestion(
      300,
      'The classification of five kingdoms is given by',
      'RH Whittaker',
      ['Margulis', 'Linnaeus', 'Theophrastus'],
    ),
    MultipleChoiceQuestion(
      300,
      'He was a Swedish botanist who lived in the 18th century that gave himself the huge task of creating a uniform system for naming all living organisms',
      'Linnaeus',
      ['Engler and Prantl', 'Bentham and Hooker', 'Margulis'],
    ),
    MultipleChoiceQuestion(
      400,
      'He published his book The Origin of Species in 1859',
      'Charles Darwin',
      ['Margulis', 'Mc Einstein', 'Aristotle'],
    ),
    MultipleChoiceQuestion(
      400,
      'A French marine biologist realized that all cells could be divided into two categories based on whether or not they had a nucleus',
      'Edouard Chatton',
      ['Wallace', 'Margulis', 'Aristotle'],
    ),
  ],
  [
    MultipleChoiceQuestion(
      500,
      'What do we call the naming system for the type of organisms that we still use until today?',
      'Binomial system of nomenclature',
      [
        'Monomial system of nomenclature',
        'Trinomial system of nomenclature',
        'None of the above'
      ],
    ),
    MultipleChoiceQuestion(
      500,
      'What are the two kinds of bacteria which Carl Woese had suggest?',
      'True bacteria and Ancient bacteria',
      [
        'Old bacteria and dead bacteria',
        'New bacteria and alive bacteria',
        'True bacteria and dead bacteria'
      ],
    ),
    PuzzleQuestion(
      600,
      'People who look for what one organism has in common with another and try to figure out the relationship between them',
      'TAXONOMISTS',
      [1, 4, 6, 9],
    ),
    PuzzleQuestion(
      600,
      'This category was not included in Linnaeus\' lineup',
      'PHYLUM',
      [0, 5],
    ),
  ],
);

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
