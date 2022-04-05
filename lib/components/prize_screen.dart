import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/models/category.dart';
import 'package:taxoplay/models/result.dart';
import 'package:taxoplay/screens/score.dart';

import '../../helpers/dialogs.dart';

class PrizeScreen extends StatefulWidget {
  const PrizeScreen({Key? key}) : super(key: key);

  @override
  PrizeScreenState createState() => PrizeScreenState();
}

class PrizeScreenState<T extends PrizeScreen> extends State<T> {
  late Category category;

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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ScoreScreen(category.name, category.score()),
                      ),
                    );
                  },
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
                              question.getScreen(category.name),
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
