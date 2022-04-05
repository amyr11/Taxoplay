import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/models/category.dart';
import 'package:taxoplay/models/result.dart';

import '../../helpers/dialogs.dart';

class QuestionTimer extends StatefulWidget {
  const QuestionTimer({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  State<QuestionTimer> createState() => _QuestionTimerState();
}

class _QuestionTimerState extends State<QuestionTimer> {
  late Timer timer;
  int seconds = 30;

  late int _remainingMinute;
  late int _remainingSeconds;

  Future<dynamic> showDialogTimed() {
    return customDialog(
      context,
      CoolAlertType.info,
      title: 'Timed Question',
      text: 'You only have $seconds seconds to answer this question.',
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultSpace / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                '${_remainingMinute.toString().padLeft(2, '0')}:${_remainingSeconds.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
