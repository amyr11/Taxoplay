import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/models/category.dart';
import 'package:taxoplay/screens/prize_screens/hist_taxonomy.dart';

import '../../components/prize_question.dart';
import '../../helpers/dialogs.dart';

class MultipleQuestionScreen extends StatefulWidget {
  final String categoryName;
  final MultipleChoiceQuestion question;

  const MultipleQuestionScreen(
      {Key? key, required this.categoryName, required this.question})
      : super(key: key);

  @override
  State<MultipleQuestionScreen> createState() => _MultipleQuestionScreenState();
}

class _MultipleQuestionScreenState extends State<MultipleQuestionScreen> {
  void setAnswer(String? answer) {
    setState(() {
      widget.question.currentAnswer = answer;
    });
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
              Navigator.pop(context, widget.question);
              Navigator.pop(context);
            },
          );
          return false;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              flex: 1,
              child: Column(
                children: [
                  DefaultButton(
                    onPressed: () {},
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
