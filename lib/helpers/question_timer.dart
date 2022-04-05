import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/result.dart';
import 'dialogs.dart';

class QuestionTimer {
  BuildContext context;
  final Question question;
  late Timer timer;
  late int _seconds;
  late int _remainingMinute;
  late int _remainingSeconds;
  late String timeString;

  QuestionTimer(this.context, this.question, {int seconds = 60}) {
    _seconds = seconds;
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
      if (_seconds > 0) {
        _seconds--;
      } else {
        _stopTimer();
      }
      updateTimeString();
    });
  }

  void updateTimeString() {
    _remainingMinute = _seconds ~/ 60;
    _remainingSeconds = _seconds - 60 * _remainingMinute;

    timeString =
        '${_remainingMinute.toString().padLeft(2, '0')}:${_remainingSeconds.toString().padLeft(2, '0')}';
  }

  void cancel() {
    timer.cancel();
  }

  void _stopTimer() {
    cancel();
    question.checkAnswer();
    Navigator.pop(context, Result(question, timeRanOut: true));
  }
}
