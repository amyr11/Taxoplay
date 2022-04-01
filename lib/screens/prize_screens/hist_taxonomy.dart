import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/models/category.dart';

const String categoryName = 'History of Taxonomy';

class HistTaxonomyScreen extends StatefulWidget {
  const HistTaxonomyScreen({Key? key}) : super(key: key);

  @override
  State<HistTaxonomyScreen> createState() => _HistTaxonomyScreenState();
}

class _HistTaxonomyScreenState extends State<HistTaxonomyScreen> {
  final Category category = Category(
    categoryName,
    [
      PuzzleQuestion(
        100,
        'Greek Philosopher who saw the hierarchy of organisms called the “Ladder of Nature"',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 30,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: kDefaultSpace / 2),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: CategoryCard(category: 'Easy'),
                        ),
                        Expanded(
                          child: CategoryCard(category: 'Average'),
                        ),
                        Expanded(
                          child: CategoryCard(category: 'Difficult'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              PrizeCard(question: category.easy[0]),
                              PrizeCard(question: category.easy[1]),
                              PrizeCard(question: category.easy[2]),
                              PrizeCard(question: category.easy[3]),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              PrizeCard(question: category.average[0]),
                              PrizeCard(question: category.average[1]),
                              PrizeCard(question: category.average[2]),
                              PrizeCard(question: category.average[3]),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              PrizeCard(question: category.difficult[0]),
                              PrizeCard(question: category.difficult[1]),
                              PrizeCard(question: category.difficult[2]),
                              PrizeCard(question: category.difficult[3]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              DefaultButton(onPressed: () {}, text: 'Show Score'),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;

  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 7,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kPrimaryColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              category,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class PrizeCard extends StatefulWidget {
  final Question question;

  const PrizeCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  State<PrizeCard> createState() => _PrizeCardState();
}

class _PrizeCardState extends State<PrizeCard> {
  void updateQuestion(bool isCorrect) {
    setState(() {
      widget.question.setAnswered(isCorrect);
    });
  }

  Color getColor() {
    if (widget.question.isAnswered) {
      if (widget.question.isCorrect) {
        return kDarkGreenColor;
      } else {
        return kDarkRedColor;
      }
    } else {
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 7,
      ),
      child: InkWell(
        onTap: () async {
          // question.getScreen();
          final isCorrect = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) =>
                      widget.question.getScreen(categoryName))));
          updateQuestion(isCorrect);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: getColor(),
            border: Border.all(
              width: 2,
              color: kPrimaryLightColor,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                '\$${widget.question.price}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
