import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/components/question_timer.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/dialogs.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/models/category.dart';
import 'package:taxoplay/models/result.dart';

import '../components/prize_question.dart';

class PuzzleScreen extends StatefulWidget {
  final String categoryName;
  final PuzzleQuestion question;

  const PuzzleScreen({
    Key? key,
    required this.categoryName,
    required this.question,
  }) : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  void addChar(int choiceIndex) {
    setState(() {
      // Find first index that has empty puzzleChar
      int emptyIndex = widget.question.puzzleChars
          .indexWhere((element) => element.currentIndex == null);

      // Add the index and value of the choice to puzzleChars
      if (emptyIndex >= 0) {
        widget.question.puzzleChars[emptyIndex].currentIndex = choiceIndex;
        widget.question.puzzleChars[emptyIndex].currentValue =
            widget.question.puzzleChoices[choiceIndex];
      }
    });
  }

  void removeChar(int charIndex) {
    // Ignore if the character tapped is a hint
    if (widget.question.puzzleChars[charIndex].isHint) {
      return;
    }

    // Remove the character from the puzzle
    setState(() {
      widget.question.puzzleChars[charIndex].clearValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("TIME: ${widget.question.timed}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: widget.question.timed
                    ? QuestionTimer(question: widget.question)
                    : null,
              ),
              Expanded(
                flex: widget.question.timed ? 5 : 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrizeAndQuestion(question: widget.question),
                    vSpace(kDefaultSpace),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: LayoutBuilder(
                        builder: (context, constraints) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: widget.question.puzzleChars.map((char) {
                            Color charColor =
                                char.isHint ? kSecondaryColor : Colors.white;

                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.5),
                                child: InkWell(
                                  onTap: () {
                                    removeChar(widget.question.puzzleChars
                                        .indexOf(char));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      char.currentValue ?? '',
                                      style: TextStyle(
                                        color: charColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: widget.question.timed ? 4 : 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1,
                          crossAxisCount: 8,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        itemCount: 16,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          bool choiceTaken = widget.question.puzzleChars
                                  .indexWhere((element) =>
                                      element.currentIndex == index) >=
                              0;

                          return LayoutBuilder(
                            builder: ((context, constraints) {
                              Color bgColor =
                                  choiceTaken ? kGreyedColor : kPrimaryColor;

                              return InkWell(
                                onTap: () {
                                  if (!choiceTaken) {
                                    addChar(index);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    choiceTaken
                                        ? ''
                                        : widget.question.puzzleChoices[index],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
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
      ),
    );
  }
}
