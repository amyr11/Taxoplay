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
      histTaxonomy,
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
        ),
        PuzzleQuestion(
          600,
          'People who look for what one organism has in common with another and try to figure out the relationship between them',
          'TAXONOMISTS',
          [1, 4, 6, 9],
        ),
        PuzzleQuestion(
          600,
          'This category was not included in Linnaeus\' lineup',
          'PHYLUM',
          [0, 5],
        ),
      ],
    );
  }
}

class GeneticsScreen extends PrizeScreen {
  const GeneticsScreen({Key? key}) : super(key: key);

  @override
  _GeneticsScreenState createState() => _GeneticsScreenState();
}

class _GeneticsScreenState extends PrizeScreenState<GeneticsScreen> {
  @override
  void initState() {
    super.initState();
    category = Category(
      genetics,
      [
        PuzzleQuestion(
          100,
          'Units of inherited traits of organisms',
          'GENES',
          [1, 4],
        ),
        PuzzleQuestion(
          100,
          'History of the evolution of species',
          'PHYLOGENY',
          [0, 2, 8],
        ),
        PuzzleQuestion(
          200,
          'Process that occurs when a trait reverts to an earlier form, creating another kind of homoplasy',
          'REVERSAL',
          [0, 7],
        ),
        PuzzleQuestion(
          200,
          'Change in a DNA sequence',
          'MUTATIONS',
          [2, 6, 8],
        ),
      ],
      [
        MultipleChoiceQuestion(
          300,
          'It is used by all known living organisms to synthesize proteins from messenger RNA',
          'rRNA',
          ['Gene', 'Chromosome', 'Phospholipid'],
        ),
        MultipleChoiceQuestion(
          300,
          'A macromolecule with a phosphate head and two fatty lipid tails',
          'Phospholipid',
          ['Chromosome', 'Broccoli', 'Gene'],
        ),
        MultipleChoiceQuestion(
          400,
          'He stitched a bunch of human body parts together and brought them to life',
          'Frankenstein',
          ['Aristotle', 'Charles Darwin', 'Margulis'],
        ),
        MultipleChoiceQuestion(
          400,
          'This is a section of DNA that codes for a protein',
          'Gene',
          ['Phospholipid', 'Chromosome', 'Plasmid'],
        ),
      ],
      [
        MultipleChoiceQuestion(
          500,
          'When do chromosomes become pulled towards opposing spindle poles by kinetochore microtubules?',
          'In anaphase A',
          [
            'In anaphase B',
            'In metaphase',
            'In telophase',
          ],
        ),
        MultipleChoiceQuestion(
          500,
          'What clade includes mollusks (Phylum Mollusca), segmented worms (Phylum Annelida), and several aquatic creatures with a ciliated ring of tentacles around their mouths',
          'Lophotrochozoa Clade',
          [
            'Ecdysozoa Clade',
            'Porifera Clade',
            'Protostomia Clade',
          ],
        ),
        PuzzleQuestion(
          600,
          'Animals characterized by their anuses forming before their mouth',
          'DEUTEROSTOMIA',
          [2, 5, 7, 10, 12],
        ),
        PuzzleQuestion(
          600,
          'Divided into two new clades, the laphotrochozoa and the Ecdysozoa',
          'PROTOSTOMES',
          [0, 5],
        ),
      ],
    );
  }
}

class ClassificationScreen extends PrizeScreen {
  const ClassificationScreen({Key? key}) : super(key: key);

  @override
  _ClassificationScreenState createState() => _ClassificationScreenState();
}

class _ClassificationScreenState
    extends PrizeScreenState<ClassificationScreen> {
  @override
  void initState() {
    super.initState();
    category = Category(
      classification,
      [
        PuzzleQuestion(
          100,
          'Greek word for nucleus',
          'KARYON',
          [0],
        ),
        PuzzleQuestion(
          100,
          'A vessel that carry dissolved organic molecules like sugar',
          'PHLOEM',
          [0],
        ),
        PuzzleQuestion(
          200,
          '“True nucleus”',
          'EUKARYOTES',
          [0, 1, 7, 9],
        ),
        PuzzleQuestion(
          200,
          'Derived from or consists of cells',
          'CELLULAR',
          [0, 2, 7],
        ),
      ],
      [
        MultipleChoiceQuestion(
          300,
          'These are haploid that only have a single copy of their genes, which is contained within a circular molecule of DNA',
          'Prokaryotes',
          ['Eukaryotes', 'Gene', 'RNA'],
        ),
        MultipleChoiceQuestion(
          300,
          'It is a membrane-bound organelle that is responsible in transporting, modifying and packaging proteins and lipids into vesicles',
          'Golgi Apparatus',
          ['Nucleus', 'Mitochondria', 'Membrane'],
        ),
        MultipleChoiceQuestion(
          400,
          'They are the organelles that generate large quantities of energy in the form of ATP',
          'Mitochondria',
          ['Membrane', 'Gene', 'RNA'],
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
          'What do chemoautotrophs use as a carbon source to oxidize molecules like ammonia (NH3) and hydrogen sulfide (H2S) for energy?',
          'Carbon dioxide',
          ['Glucose Carbon', 'Monoxide', 'Carbonate ion'],
        ),
        MultipleChoiceQuestion(
          500,
          'What is the repeating macromolecule made of amino acids and sugars that form an interconnecting web that gives bacterial cell walls structure and strength',
          'Peptidoglycan',
          ['Thermophilican', 'Crenarchaeotacan', 'Euryarchaeotacan'],
        ),
        PuzzleQuestion(
          600,
          'Microscopic organism found in all types of water',
          'CYANOBACTERIA',
          [0, 3, 7, 10, 12],
        ),
        PuzzleQuestion(
          600,
          'Use inorganic molecules to make organic molecules',
          'CHEMOAUTOTROPHS',
          [2, 4, 7, 10, 12],
        ),
      ],
    );
  }
}
