import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:taxoplay/components/logo_with_text.dart';
import 'package:taxoplay/constants.dart';

import '../components/sidebar.dart';

class GameInstructionScreen extends StatelessWidget {
  GameInstructionScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  final pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);

  final List<LogoWithText> instructions = [
    const LogoWithText(
      header: 'How to play Taxoplay?',
      body:
          'TaxoPlay is divided into three rounds for every category; easy, average, and difficult round.',
    ),
    const LogoWithText(
      header: 'Easy Round',
      body:
          "A combination of multiple-choice questions and a word puzzle will appear per price. The player's goal is to figure out the word and answer each question. The aim of completing the puzzle is to find the word using a hint and a set of letters provided below the puzzle.",
    ),
    const LogoWithText(
      header: 'Average Round',
      body:
          "Random questions will appear per price. The player’s goal is to figure out the correct answer among the four choices available for the specific question.",
    ),
    const LogoWithText(
      header: 'Difficult Round',
      body:
          "A combination of multiple-choice questions and a word puzzle will emerge per price and with a time limit decreasing as the price increases. The player aims to figure out the correct answer or word before their time stops.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Instruction"),
      ),
      drawer: SideBar(highlighted: id),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: builPageView(),
          ),
          Expanded(
            child: CirclePageIndicator(
              selectedDotColor: kSecondaryColor,
              dotColor: kGreyedColor,
              itemCount: instructions.length,
              currentPageNotifier: currentPageNotifier,
            ),
          ),
        ],
      ),
    );
  }

  Widget builPageView() {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: instructions.length,
      controller: pageController,
      itemBuilder: (context, index) {
        return instructions[index];
      },
      onPageChanged: (int index) {
        currentPageNotifier.value = index;
      },
    );
  }
}
