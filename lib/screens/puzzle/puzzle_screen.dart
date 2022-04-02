import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';
import 'package:taxoplay/models/category.dart';
import 'package:taxoplay/screens/prize_screens/hist_taxonomy.dart';

class PuzzleScreen extends StatefulWidget {
  final String categoryName;
  final PuzzleQuestion question;

  const PuzzleScreen(
      {Key? key, required this.categoryName, required this.question})
      : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(categoryName),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);
          return false;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: kDefaultSpace / 2),
                      child: Text(
                        '\$${widget.question.price}',
                        style: const TextStyle(fontSize: 34),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultSpace / 3,
                        vertical: kDefaultSpace / 2,
                      ),
                      child: Text(
                        widget.question.question,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
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
                                  addChar(index);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    widget.question.puzzleChoices[index],
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
                    DefaultButton(onPressed: () {}, text: 'Submit'),
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
