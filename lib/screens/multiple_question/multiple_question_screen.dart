import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/models/category.dart';
import 'package:taxoplay/models/result.dart';
import 'package:taxoplay/screens/prize_screens/hist_taxonomy.dart';

import '../../components/prize_question.dart';
import '../../helpers/dialogs.dart';

class MultipleQuestionScreen extends StatefulWidget {
  final String categoryName;
  final MultipleChoiceQuestion question;
  final bool timed;

  const MultipleQuestionScreen(
      {Key? key,
      required this.categoryName,
      required this.question,
      this.timed = false})
      : super(key: key);

  @override
  State<MultipleQuestionScreen> createState() => _MultipleQuestionScreenState();
}

class _MultipleQuestionScreenState extends State<MultipleQuestionScreen> {
  late Timer timer;
  int seconds = 60;

  late int _remainingMinute;
  late int _remainingSeconds;

  void setAnswer(String? answer) {
    setState(() {
      widget.question.currentAnswer = answer;
    });
  }

  Future<dynamic> showDialogTimed() {
    return customDialog(
      context,
      CoolAlertType.info,
      title: 'Timed Question',
      text: 'You only have 1 minute to answer this question.',
      confirmBtnText: 'Proceed',
      barrierDismissible: false,
    );
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
        updateTimeString();
      });
    });
  }

  void stopTimer() {
    timer.cancel();
    widget.question.checkAnswer();
    Navigator.pop(context, Result(widget.question, timeRanOut: true));
  }

  void updateTimeString() {
    _remainingMinute = seconds ~/ 60;
    _remainingSeconds = seconds - 60 * _remainingMinute;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      showDialogTimed().then((_) => startTimer());
    });
    updateTimeString();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(categoryName),
      ),
      body: WillPopScope(
        onWillPop: () async {
          // Notify user that changes will not be saved
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
              Navigator.pop(context, Result(widget.question));
              Navigator.pop(context);
            },
          );
          return false;
        },
        child: Column(
          children: [
            Expanded(
              flex: widget.timed ? 1 : 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: widget.timed
                    ? CustomTimer(
                        time:
                            '${_remainingMinute.toString().padLeft(2, '0')}:${_remainingSeconds.toString().padLeft(2, '0')}',
                      )
                    : null,
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrizeAndQuestion(question: widget.question),
                  vSpace(kDefaultSpace),
                  ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: kDefaultSpace / 3),
                    shrinkWrap: true,
                    itemCount: widget.question.choices.length,
                    itemBuilder: (context, index) {
                      String value = widget.question.choices[index];

                      return InkWell(
                        onTap: () {
                          setAnswer(value);
                        },
                        child: Row(
                          children: [
                            Radio<String>(
                              fillColor: MaterialStateProperty.all<Color>(
                                  kSecondaryColor),
                              value: widget.question.choices[index],
                              groupValue: widget.question.currentAnswer,
                              onChanged: (String? value) {
                                setAnswer(value);
                              },
                            ),
                            hSpace(10),
                            Text(
                              widget.question.choices[index],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: widget.timed ? 2 : 1,
              child: Column(
                mainAxisAlignment: widget.timed
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  DefaultButton(
                    enabled: widget.question.isDone(),
                    onPressed: () {
                      widget.question.checkAnswer();
                      Navigator.pop(context, Result(widget.question));
                    },
                    text: 'Submit',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTimer extends StatelessWidget {
  const CustomTimer({
    Key? key,
    required this.time,
  }) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultSpace / 2, horizontal: kDefaultSpace / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kPrimaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
              child: Text(
                time,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
