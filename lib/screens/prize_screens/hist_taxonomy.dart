import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/models/category.dart';
import 'package:taxoplay/models/result.dart';

import '../../helpers/dialogs.dart';

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
        ],
        includeNone: true,
        timed: true,
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
        timed: true,
      ),
      PuzzleQuestion(
        600,
        'People who look for what one organism has in common with another and try to figure out the relationship between them',
        'TAXONOMISTS',
        [1, 4, 6, 9],
        timed: true,
      ),
      PuzzleQuestion(
        600,
        'This category was not included in Linnaeus\' lineup',
        'PHYLUM',
        [0, 5],
        timed: true,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WillPopScope(
        onWillPop: () async {
          customDialog(
            context,
            CoolAlertType.warning,
            title: 'Warning',
            text:
                'Are you sure you want to leave?\nYour progress will not be saved.',
            confirmBtnText: 'Cancel',
            cancelBtnText: 'Leave',
            showCancelBtn: true,
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            onCancelBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
          return false;
        },
        child: Center(
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
                              children: [buildRoundColumn('easy')],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [buildRoundColumn('average')],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [buildRoundColumn('difficult')],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DefaultButton(
                  enabled: category.isComplete,
                  onPressed: () {},
                  text: 'Show Score',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateQuestion(String round, int index, Question updatedQuestion) async {
    if (mounted) {
      setState(() {
        category.updateQuestion(round, index, updatedQuestion);
      });
    }
  }

  void showDialog(Result result) async {
    Question question = result.updatedQuestion;

    if (mounted && question.isAnswered) {
      CoolAlertType alertType;
      String title;
      String text;

      if (question.isCorrect) {
        alertType = CoolAlertType.success;
        title = 'Correct';
        text = '+\$${question.price}';
      } else {
        alertType = CoolAlertType.error;
        title = result.timeRanOut ? 'Time\'s Up!' : 'Wrong';
        text = 'The correct answer is \n"${question.answer}"';
      }

      await Future.delayed(const Duration(milliseconds: 500));
      customDialog(
        context,
        alertType,
        title: title,
        text: text,
        confirmBtnText: 'Proceed',
        onConfirmBtnTap: () {
          Navigator.pop(context);
        },
        barrierDismissible: false,
      );
    }
  }

  ListView buildRoundColumn(String round) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: category.questions[round]!.length,
        itemBuilder: (context, index) {
          Question question = category.questions[round]![index];

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 7,
            ),
            child: InkWell(
              onTap: !question.isAnswered
                  ? () async {
                      final Result result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              question.getScreen(categoryName),
                        ),
                      );
                      updateQuestion(round, index, result.updatedQuestion);
                      showDialog(result);
                    }
                  : null,
              child: AnimatedCrossFade(
                  firstChild: buildPriceCard(question, Colors.transparent),
                  secondChild: question.isCorrect
                      ? buildPriceCard(question, kDarkGreenColor)
                      : buildPriceCard(question, kDarkRedColor),
                  crossFadeState: question.isAnswered
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 500)),
            ),
          );
        });
  }

  Container buildPriceCard(Question question, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
        border: Border.all(
          width: 2,
          color: kPrimaryLightColor,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            '\$${question.price}',
            style: const TextStyle(fontSize: 20),
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
