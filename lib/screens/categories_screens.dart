import 'package:flutter/material.dart';
import 'package:taxoplay/components/prize_screen.dart';
import 'package:taxoplay/models/category.dart';

class HistTaxonomyScreen extends PrizeScreen {
  const HistTaxonomyScreen({Key? key}) : super(key: key);

  @override
  _HistTaxonomyScreenState createState() => _HistTaxonomyScreenState();
}

class _HistTaxonomyScreenState extends PrizeScreenState<HistTaxonomyScreen> {
  @override
  void initState() {
    super.initState();
    category = Category(
      'History of Taxonomy',
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
  }
}
