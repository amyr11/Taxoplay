import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/models/category.dart';
import 'package:taxoplay/models/result.dart';
import 'package:taxoplay/screens/score.dart';

import '../../helpers/dialogs.dart';

class PrizeScreen extends StatefulWidget {
  const PrizeScreen({Key? key, required this.categoryName, required this.round})
      : super(key: key);

  final String categoryName;
  final CategoryRound round;

  @override
  State<PrizeScreen> createState() => _PrizeScreenState();
}

class _PrizeScreenState extends State<PrizeScreen> {
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
                  widget.round.difficulty,
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
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                buildRoundColumn(
                                    widget.round.questions.sublist(0, 4))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                buildRoundColumn(
                                    widget.round.questions.sublist(4, 8))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                buildRoundColumn(
                                    widget.round.questions.sublist(8, 12))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DefaultButton(
                  enabled: widget.round.isComplete,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScoreScreen(
                            widget.categoryName, widget.round.score()),
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

  void updateQuestion(int index, Question updatedQuestion) async {
    if (mounted) {
      setState(() {
        widget.round.updateQuestion(index, updatedQuestion);
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

  ListView buildRoundColumn(List<Question> questions) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          Question question = questions[index];

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
                              question.getScreen(widget.categoryName),
                        ),
                      );
                      updateQuestion(widget.round.questions.indexOf(question),
                          result.updatedQuestion);
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
          padding: const EdgeInsets.symmetric(vertical: 20),
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
