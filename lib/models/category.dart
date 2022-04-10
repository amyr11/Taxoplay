import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taxoplay/helpers/sp_helper.dart';
import 'package:taxoplay/screens/multiple_question_screen.dart';
import 'package:taxoplay/screens/puzzle_screen.dart';

const String histTaxonomy = 'History of Taxonomy';
const String genetics = 'Genetics';
const String classification = 'Classification';

class Difficulty {
  static const String easy = 'Easy';
  static const String average = 'Average';
  static const String difficult = 'Difficult';
}

class Category {
  final String name;
  final Map<String, CategoryRound> _rounds = {};

  Category(this.name, List<Question> easy, List<Question> average,
      List<Question> difficult) {
    _rounds[Difficulty.easy] = CategoryRound(name, Difficulty.easy, easy);
    _rounds[Difficulty.average] =
        CategoryRound(name, Difficulty.average, average);
    _rounds[Difficulty.difficult] =
        CategoryRound(name, Difficulty.difficult, difficult);
  }

  CategoryRound? getRound(String difficulty) {
    return _rounds[difficulty];
  }

  static void resetBestScores() {
    SPHelper.sp.empty(histTaxonomy);
    SPHelper.sp.empty(genetics);
    SPHelper.sp.empty(classification);
  }
}

class CategoryRound {
  final String categoryName;
  final String difficulty;
  late final String spString;
  final List<Question> questions;
  bool isComplete = false;
  final String _notCompleteError =
      'This round was scored but was not finished yet.';

  CategoryRound(this.categoryName, this.difficulty, this.questions) {
    spString = '$categoryName.$difficulty';
  }

  void _checkComplete() {
    bool complete = true;
    for (Question question in questions) {
      if (!question.isAnswered) {
        complete = false;
        break;
      }
    }
    isComplete = complete;
    if (isComplete) _saveScore();
  }

  void updateQuestion(String round, int index, Question updated) {
    questions[index] = updated;
    _checkComplete();
  }

  int score() {
    assert(isComplete, _notCompleteError);

    int score = 0;
    for (Question question in questions) {
      score += question.isCorrect ? question.price : 0;
    }
    return score;
  }

  void _saveScore() async {
    assert(isComplete, _notCompleteError);

    int score = this.score();
    int bestScore = SPHelper.sp.getInt(spString) ?? 0;

    if (score > bestScore) {
      SPHelper.sp.setInt(spString, score);
    }
  }
}

abstract class Question {
  final int price;
  final String question;
  final String answer;
  bool isAnswered = false;
  bool isCorrect = false;
  final int time;

  Question(this.price, this.question, this.answer, {this.time = 0});

  Widget getScreen(String categoryName);

  void checkAnswer() {
    isAnswered = true;
  }

  bool isDone();
}

const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

class PuzzleQuestion extends Question {
  final List<int> hints;
  List<PuzzleChar> puzzleChars = [];
  List<String> puzzleChoices = [];

  PuzzleQuestion(int price, String question, String answer, this.hints,
      {int time = 0})
      : super(price, question, answer) {
    List<String> splitAnswer = answer.split('').toList();
    for (int i = 0; i < splitAnswer.length; i++) {
      bool isHint = hints.contains(i);
      String correctValue = answer[i];
      String? currentValue = isHint ? correctValue : null;
      int? currentIndex = isHint ? -1 : null;

      puzzleChars
          .add(PuzzleChar(currentValue, currentIndex, correctValue, isHint));
    }
    puzzleChoices.addAll(splitAnswer);
    for (int i = puzzleChoices.length; i < 16; i++) {
      puzzleChoices.add(alphabet[Random().nextInt(alphabet.length)]);
    }
    puzzleChoices.shuffle();
  }

  @override
  Widget getScreen(String categoryName) {
    return PuzzleScreen(
      categoryName: categoryName,
      question: this,
      time: time,
    );
  }

  @override
  bool isDone() {
    // Find puzzleChars with empty currentIndex
    List<PuzzleChar> emptyChars =
        puzzleChars.where((element) => element.currentIndex == null).toList();
    return emptyChars.isEmpty;
  }

  @override
  void checkAnswer() {
    super.checkAnswer();
    for (PuzzleChar char in puzzleChars) {
      if (!char.evaluate()) {
        return;
      }
    }
    isCorrect = true;
  }
}

class PuzzleChar {
  String? currentValue;
  int? currentIndex;
  String correctValue;
  bool isHint;

  PuzzleChar(
      this.currentValue, this.currentIndex, this.correctValue, this.isHint);

  void clearValue() {
    currentValue = null;
    currentIndex = null;
  }

  bool evaluate() {
    return currentValue == correctValue;
  }
}

class MultipleChoiceQuestion extends Question {
  final List<String> wrongAnswers;
  final List<String> _choices = [];
  String? currentAnswer;

  get choices => _choices;

  MultipleChoiceQuestion(
      int price, String question, String answer, this.wrongAnswers,
      {bool includeNone = false, int time = 0})
      : super(price, question, answer) {
    _choices.add(answer);
    _choices.addAll(wrongAnswers);
    _choices.shuffle();

    if (includeNone) {
      _choices.add('None of the above');
    }
  }

  @override
  Widget getScreen(String categoryName) {
    return MultipleQuestionScreen(
      categoryName: categoryName,
      question: this,
      time: time,
    );
  }

  @override
  void checkAnswer() {
    super.checkAnswer();
    isCorrect = currentAnswer == answer;
  }

  @override
  bool isDone() {
    return currentAnswer != null;
  }
}

Category getHistoryCategory() {
  return Category(
    histTaxonomy,
    [
      PuzzleQuestion(
        100,
        "Greek Philosopher who saw the hierarchy of organisms called the “Ladder of Nature”",
        "ARISTOTLE",
        [2, 4, 7],
      ),
      PuzzleQuestion(
        100,
        "One of the three major domains",
        "EUKARYA",
        [0, 2, 6],
      ),
      PuzzleQuestion(
        200,
        "Animals with bony backbones",
        "VERTEBRATES",
        [0, 2, 6, 10],
      ),
      PuzzleQuestion(
        200,
        "Smallest category in the hierarchical classification of organisms",
        "SPECIES",
        [0, 1, 6],
      ),
      PuzzleQuestion(
        300,
        "They were usually green and stationary, and can reproduce and grow",
        "PLANTS",
        [2, 5],
      ),
      PuzzleQuestion(
        300,
        "A group of living things with certain similar characteristics",
        "KINDS",
        [2],
      ),
      MultipleChoiceQuestion(
        400,
        "All the individual organisms of a kind or taxon, or a group of organisms living in an area",
        "Population",
        ["Organization", "Variation", "Biome"],
      ),
      MultipleChoiceQuestion(
        400,
        "Differences that occur among the offspring of a particular species",
        "Variation",
        ["Fixity of Species", "Differentiation", "Classification"],
      ),
      MultipleChoiceQuestion(
        500,
        "Workable principles of taxonomy and genetics had not been developed when Moses recorded this book",
        "Genesis",
        ["Exodus", "Leviticus", "Deuteronomy"],
      ),
      MultipleChoiceQuestion(
        500,
        "A taxonomic category containing a group of similar genera",
        "Family",
        ["Group", "Domain", "Kingdom"],
      ),
      MultipleChoiceQuestion(
        600,
        "Which branch of the Life Sciences is primarily concerned with the naming of species?",
        "Taxonomy",
        ["Zoology", "Synonomy", "Phylogeny"],
      ),
      MultipleChoiceQuestion(
        600,
        "A plan or arrangement of grouping categories for the purpose of classifying",
        "Taxonomic System",
        ["Classification System", "Variation System", "Population System"],
      ),
    ],
    [
      MultipleChoiceQuestion(
        100,
        "The classification of five kingdoms is given by",
        "RH Whittaker",
        ["Margulis", "Linnaeus", "Theophrastus"],
      ),
      MultipleChoiceQuestion(
        100,
        "He was a Swedish botanist who lived in the 18th century that gave himself the huge task of creating a uniform system for naming all living organisms",
        "Linnaeus",
        ["Engler and Prantl", "Bentham and Hooker", "Margulis"],
      ),
      MultipleChoiceQuestion(
        200,
        "He published his book The Origin of Species in 1859",
        "Charles Darwin",
        ["Margulis", "Linnaeus", "Aristotle"],
      ),
      MultipleChoiceQuestion(
        200,
        "A French marine biologist realized that all cells could be divided into two categories based on whether or not they had a nucleus",
        "Edouard Chatton",
        ["Wallace", "Margulis", "Aristotle"],
      ),
      MultipleChoiceQuestion(
        300,
        "One of the first scientists of the Renaissance to advance taxonomy through first hand observations",
        "Cordus",
        ["Margulis", "Wallace", "Aristotle"],
      ),
      MultipleChoiceQuestion(
        300,
        "Linnaeus classified plants according to their",
        "Flower",
        ["Roots", "Stem", "Leaves"],
      ),
      MultipleChoiceQuestion(
        400,
        "The accelerated growth and advances in taxonomy as a science occurred during what period",
        "Renaissance",
        ["Medieval", "Classical", "Industrial"],
      ),
      MultipleChoiceQuestion(
        400,
        'Theophrastus was considered the "Father of Botany" in the approximate year',
        "300 B.C",
        ["500 B.C", "400 B.C", "200 B.C"],
      ),
      MultipleChoiceQuestion(
        500,
        'Who wrote what we might call the "bible of taxonomy" in 1758',
        "Linnaeus",
        ["Aristotle", "I. Geoffroy", "Ray"],
      ),
      MultipleChoiceQuestion(
        500,
        "He introduced a new method of grouping by similarities in appearance",
        "Ray",
        ["Aristotle", "Linnaeus", "I. Geoffroy"],
      ),
      MultipleChoiceQuestion(
        600,
        "In ancient times people classified plants and animals by",
        "Use",
        ["Kind", "Color", "Family"],
      ),
      MultipleChoiceQuestion(
        600,
        "Scientists resumed observing and studying real plants and animals during this period",
        "Renaissance",
        ["Medieval", "Classical", "Industrial"],
      ),
    ],
    [
      PuzzleQuestion(
          100,
          "People who look for what one organism has in common with another and try to figure out the relationship between them",
          "TAXONOMISTS",
          [1, 4, 6, 9],
          time: 45),
      PuzzleQuestion(100, "This category was not included in Linnaeus’s lineup",
          "PHYLUM", [0, 5],
          time: 45),
      PuzzleQuestion(200, "The scientist who formally named the gorilla",
          "GEOFFROY", [2, 5],
          time: 40),
      PuzzleQuestion(
          200, "Animals that gave birth to live babies", "MAMMALS", [0],
          time: 40),
      PuzzleQuestion(
          300,
          "Swiss botanist that make the names of plants less descriptive",
          "BAUHIN",
          [1, 4],
          time: 35),
      PuzzleQuestion(
          300,
          "A system of distinguishing groups for purposes of identification",
          "CLASSIFICATION",
          [1, 4, 9, 13],
          time: 35),
      MultipleChoiceQuestion(
        400,
        "What do we call the naming system for the type of organisms that we still use until today",
        "Binomial system of nomenclature",
        ["Monomial system of nomenclature", "Trinomial system of nomenclature"],
        includeNone: true,
        time: 30,
      ),
      MultipleChoiceQuestion(
        400,
        "What are the two kinds of bacteria which Carl Woese had suggest",
        "True bacteria and Ancient bacteria",
        [
          "Old bacteria and dead bacteria",
          "New bacteria and alive bacteria",
          "True bacteria and dead bacteria"
        ],
        time: 30,
      ),
      MultipleChoiceQuestion(
        500,
        "Linnaeus' concept of kinds differed from ours today in holding that",
        "variation does not exist within a kind",
        [
          "variation does not exist within a family",
          "variation does not exist within a population",
          "variation does not exist within a group"
        ],
        time: 25,
      ),
      MultipleChoiceQuestion(
        500,
        "On what basis did Linnaeus group species in his classifications",
        "their similarities and differences",
        [
          "their geographic origin",
          "their phylogenetic relationships",
          "their taxonomy"
        ],
        time: 25,
      ),
      MultipleChoiceQuestion(
        600,
        "Which one of the following pairs of historical figures contributed to the early development of taxonomy",
        "Linnaeus and Ray",
        [
          "Linnaeus and Darwin",
          "Hanno and Cortes",
          "Magellan and Theophrastus"
        ],
        time: 20,
      ),
      MultipleChoiceQuestion(
        600,
        "Rather accurate, traditional, non-scientific biological knowledge can be found in",
        "Folk Taxonomy",
        [
          "Allegorical Classification",
          "Historical Sagas",
          "Mythological Anecdote"
        ],
        time: 20,
      ),
    ],
  );
}

Category getGeneticsCategory() {
  return Category(
    genetics,
    [
      PuzzleQuestion(
        100,
        "Units of inherited traits of organisms",
        "GENES",
        [1, 4],
      ),
      PuzzleQuestion(
        100,
        "History of the evolution of species",
        "PHYLOGENY",
        [0, 2, 8],
      ),
      PuzzleQuestion(
        200,
        "Process that occurs when a trait reverts to an earlier form, creating another type of homoplasy",
        "REVERSAL",
        [0, 7],
      ),
      PuzzleQuestion(
        200,
        "Change in a DNA sequence",
        "MUTATIONS",
        [2, 6, 8],
      ),
      PuzzleQuestion(
        300,
        "The scientific study of heredity",
        "GENETICS",
        [2, 5],
      ),
      PuzzleQuestion(
        300,
        "Augustinian monk and botanist who is the founder of the science of genetics",
        "MENDEL",
        [0, 3],
      ),
      MultipleChoiceQuestion(
        400,
        "Specific physical characteristic that varies from one individual to another",
        "Traits",
        ["Genes", "DNA", "Attribute"],
      ),
      MultipleChoiceQuestion(
        400,
        "Which of these is a correct type of mutation",
        "Substitution",
        ["Addition", "Polymerase", "Transcription"],
      ),
      MultipleChoiceQuestion(
        500,
        "Gregor Mendel was",
        "a little known Central European monk",
        [
          "an English scientist who carried out research with Charles Darwin",
          "an early 20th century Dutch biologist who carried out genetics research",
          "the first Nobel Prize awardee for genetics"
        ],
      ),
      MultipleChoiceQuestion(
        500,
        "It is a genotype with two different alleles",
        "Hybrid",
        ["Gamete", "Heterozygous", "Homozygous"],
      ),
      MultipleChoiceQuestion(
        600,
        "This is the differen forms of a gene",
        "Allele",
        ["Gamete", "Zygote", "Trait"],
      ),
      MultipleChoiceQuestion(
        600,
        "Specialized cell involved in sexual reproduction",
        "Gamete",
        ["Zygote", "Allele", "Spore"],
      ),
    ],
    [
      MultipleChoiceQuestion(
        100,
        "It is used by all known living organisms to synthesize proteins from messenger RNA",
        "rRNA",
        ["Gene", "Chromosome", "Phospholipid"],
      ),
      MultipleChoiceQuestion(
        100,
        "A macromolecule with a phosphate head and two fatty lipid tails",
        "Phospholipid",
        ["Chromosome", "Gene", "Broccoli"],
      ),
      MultipleChoiceQuestion(
        200,
        "He stitched a bunch of human body parts together and brought them to life",
        "Frankenstein",
        ["Charles Darwin", "Aristotle", "Margulis"],
      ),
      MultipleChoiceQuestion(
        200,
        "This is a section of DNA that codes for a protein",
        "Gene",
        ["Chromosome", "Phospholipid", "Plasmid"],
      ),
      MultipleChoiceQuestion(
        300,
        "Term used to describe organisms that produce offspring identical to themselves if allowed to self-pollinate",
        "True Breeding",
        ["Cross Breeding", "Self Breeding", "Good Breeding"],
      ),
      MultipleChoiceQuestion(
        300,
        "Process in which male and female reproductive cells join to form a new cell",
        "Fertilization",
        ["Reproduction", "Duplication", "Transcription"],
      ),
      MultipleChoiceQuestion(
        400,
        "The likelihood that a particular event will occur",
        "Probability",
        ["Chance", "Feasibility", "Contingency"],
      ),
      MultipleChoiceQuestion(
        400,
        "A chart that shows all the possible combinations of alleles that can result from a genetic cross",
        "Punnett Square",
        ["Allele Chart", "Allele Square", "Punnett Chart"],
      ),
      MultipleChoiceQuestion(
        500,
        "The physical traits that appear in an individual as a result of its genetic make up",
        "Phenotype",
        ["Genotype", "Heterotype", "Homotype"],
      ),
      MultipleChoiceQuestion(
        500,
        "Scientific term for having two dominant alleles for a trait",
        "Homozygous Dominant",
        [
          "Heterozygous Dominant",
          "Homozygous Recessive",
          "Heterozygous Recessive"
        ],
      ),
      MultipleChoiceQuestion(
        600,
        "Scientific term for having two recessive alleles for a trait",
        "Homozygous Recessive",
        [
          "Homozygous Dominant",
          "Heterozygous Dominant",
          "Heterozygous Recessive"
        ],
      ),
      MultipleChoiceQuestion(
        600,
        "Creates a blended phenotype; one allele is not completely dominant over the other",
        "Incomplete Dominance",
        [
          "Incomplete Blending",
          "Incomplete Segregation",
          "Incomplete Recession"
        ],
      ),
    ],
    [
      PuzzleQuestion(
          100,
          "Animals characterized by their anuses forming before their mouth",
          "DEUTEROSTOMIA",
          [2, 5, 7, 10, 12],
          time: 45),
      PuzzleQuestion(
          100,
          "Divided into two new clades, the Laphotrochozoa and the Ecdysozoa",
          "PROTOSTOMES",
          [0, 3, 10],
          time: 45),
      PuzzleQuestion(
          200,
          "Scientific term for having two different alleles for a trait",
          "HETEROZYGOUS",
          [2, 5, 10],
          time: 40),
      PuzzleQuestion(
          200,
          "Situation in which both alleles of a gene contribute to the phenotype of the organism",
          "CODOMINANCE",
          [0, 3, 8],
          time: 40),
      PuzzleQuestion(
          300,
          "An organism or cell having only a half set of chromosomes",
          "HAPLOID",
          [1, 4],
          time: 35),
      PuzzleQuestion(
          300,
          "Cell division that produces reproductive cells in sexually reproducing organisms",
          "MEIOSIS",
          [1, 5],
          time: 35),
      MultipleChoiceQuestion(
        400,
        "When do chromosomes become pulled towards opposing spindle poles by kinetochore microtubules",
        "In anaphase A",
        ["In anaphase B", "In metaphase", "In telophase"],
        time: 30,
      ),
      MultipleChoiceQuestion(
        400,
        "What clade includes mollusks (Phylum Mollusca), segmented worms (Phylum Annelida), and several aquatic creatures with a ciliated ring of tentacles around their mouths",
        "Lophotrochozoa Clade",
        ["Ecdysozoa Clade", "Porifera Clade", "Protostomia Clade"],
        time: 30,
      ),
      MultipleChoiceQuestion(
        500,
        "Which of the following statements is true about Mendel",
        "His ideas about genetics apply equally to plants and animals",
        [
          "His discoveries concerning genetic inheritance were generally accepted by the scientific community when he published them during the mid 19th century",
          "He believed that genetic traits of parents will usually blend in their children"
        ],
        includeNone: true,
        time: 25,
      ),
      MultipleChoiceQuestion(
        500,
        "Mendel believed that the characteristics of pea plants are determined by the",
        "Inheritance of units or factors from both parents",
        [
          "Inheritance of units or factors from one parent",
          "Relative health of both parent plants at the time of pollination",
          "Relative health of one parent plant at the time of pollination"
        ],
        time: 25,
      ),
      MultipleChoiceQuestion(
        600,
        "The idea that different pairs of alleles are passed to offspring independently is Mendel's principle of",
        "Independent Assortment",
        ["Segregation", "Unit Inheritance", "Hybridization"],
        time: 20,
      ),
      MultipleChoiceQuestion(
        600,
        "The idea that for any particular trait, the pair of alleles of each parent separate and only one allele from each parent passes to an offspring is Mendel's principle of",
        "Segregation",
        ["Unit Inheritance", "Hybridization", "Independent Assortment"],
        time: 20,
      ),
    ],
  );
}

Category getClassificationCategory() {
  return Category(
    classification,
    [
      PuzzleQuestion(
        100,
        "Greek word for nucleus",
        "KARYON",
        [0],
      ),
      PuzzleQuestion(
        100,
        "A vessel that carries dissolved organic molecules like sugar",
        "PHLOEM",
        [0],
      ),
      PuzzleQuestion(
        200,
        "“True nucleus”",
        "EUKARYOTES",
        [0, 1, 7, 9],
      ),
      PuzzleQuestion(
        200,
        "Derived from or consists of cells",
        "CELLULAR",
        [0, 2, 7],
      ),
      PuzzleQuestion(
        300,
        "Unicellular or multicellular, get food from around them",
        "FUNGI",
        [1],
      ),
      PuzzleQuestion(
        300,
        "Multicellular, nuclei, make food through photosynthesis",
        "PLANTS",
        [1, 3],
      ),
      MultipleChoiceQuestion(
        400,
        "A taxon is a",
        "taxonomic group of any ranking",
        [
          "group of related families",
          "group of related species",
          "type of living organism"
        ],
      ),
      MultipleChoiceQuestion(
        400,
        "Branch of science that deals with identification, nomenclature, and classification of organisms is called",
        "Systematics",
        ["Cytology", "Genetics", "Nomenclature"],
      ),
      MultipleChoiceQuestion(
        500,
        "A group of plants or animals with similar traits of any rank is",
        "Species",
        ["Genus", "Order", "Taxon"],
      ),
      MultipleChoiceQuestion(
        500,
        "Basic unit or smallest taxon of taxonomy is",
        "Species",
        ["Genus", "Family", "Variety"],
      ),
      MultipleChoiceQuestion(
        600,
        "If two organisms are in the same phylum, they must also be in the same",
        "Kingdom",
        ["Class", "Family", "Species"],
      ),
      MultipleChoiceQuestion(
        600,
        "Genus represents",
        "a group of closely related species of plants or animals",
        [
          "a collection of plants or animals",
          "an individual plant or animal",
          "group of plants or animals with related families"
        ],
      ),
    ],
    [
      MultipleChoiceQuestion(
        100,
        "These are haploid that only have a single copy of their genes, which is contained within a circular molecule of DNA",
        "eukaryotes",
        ["prokaryotes", "gene", "RNA"],
      ),
      MultipleChoiceQuestion(
        100,
        "It is a membrane-bound organelle that is responsible in transporting, modifying and packaging proteins and lipids into vesicles",
        "Golgi Apparatus",
        ["Mitochondria", "Nucleus", "Membrane"],
      ),
      MultipleChoiceQuestion(
        200,
        "They are the organelles that generate large quantities of energy in the form of ATP",
        "mitochondria",
        ["gene", "membrane", "RNA"],
      ),
      MultipleChoiceQuestion(
        200,
        "It is the thin layer that forms the outer boundary of a cell",
        "membrane",
        ["cytoplasm", "plasma", "chromatin"],
      ),
      MultipleChoiceQuestion(
        300,
        "The taxonomic unit 'Phylum' in the classification of animals is equivalent to which hierarchial level in classification of plants",
        "Division",
        ["Class", "Order", "Family"],
      ),
      MultipleChoiceQuestion(
        300,
        "Which  of the following is a defining characteristic of living organism",
        "Reproduction",
        ["Growth", "Ability to make sound", "Response to external stimuli"],
      ),
      MultipleChoiceQuestion(
        400,
        "Family is placed between",
        "species and genus",
        ["order and genus", "genus and class", "order and class"],
      ),
      MultipleChoiceQuestion(
        400,
        "A system of classification in which all important characters are considered is",
        "Natural System",
        ["Artificial System", "Phylogenetic System", "Taxonomic System"],
      ),
      MultipleChoiceQuestion(
        500,
        "Mode of arranging organism into categories is called",
        "Classification",
        ["Identification", "Nomenclature", "Taxonomy"],
      ),
      MultipleChoiceQuestion(
        500,
        "The scientific name when printed should be",
        "in italic",
        ["underlined", "in small letter", "in capital letter"],
      ),
      MultipleChoiceQuestion(
        600,
        "The scientist who created the group Protista for both unicellular plants and animal cell was",
        "Haeckel",
        ["Pasteur", "Bentham", "Linnaeus"],
      ),
      MultipleChoiceQuestion(
        600,
        "In two kingdom system of classification Euglena is included in",
        "Animalia",
        ["Plantae", "Protista", "Both Plantae and Protista"],
      ),
    ],
    [
      PuzzleQuestion(100, "Microscopic organism found in all types of water",
          "CYANOBACTERIA", [0, 3, 7, 10, 12],
          time: 45),
      PuzzleQuestion(100, "Use inorganic molecules to make organic molecules",
          "CHEMOAUTOTROPHS", [2, 4, 7, 10, 12],
          time: 45),
      PuzzleQuestion(200, "Julian Huxley developed the concept of new",
          "SYSTEMATICS", [1, 4, 10],
          time: 40),
      PuzzleQuestion(
          200,
          "The first ever monograph of a plant taxon was given by",
          "MORISON",
          [0, 5],
          time: 40),
      PuzzleQuestion(300, "Phylogenetic classification is based on",
          "CLADISTICS", [1, 4, 8],
          time: 35),
      PuzzleQuestion(300, "Five Kingdom of classification is given by",
          "WHITTAKER", [1, 3, 6],
          time: 35),
      MultipleChoiceQuestion(
        400,
        "What do chemoautotrophs use as a carbon source to oxidize molecules like ammonia (NH3) and hydrogen sulfide (H2S) for energy",
        "Carbon dioxide",
        ["Glucose Carbon", "monoxide", "Carbonate ion"],
        time: 30,
      ),
      MultipleChoiceQuestion(
        400,
        "What is the repeating macromolecule made of amino acids and sugars that form an interconnecting web that gives bacterial cell walls structure and strength",
        "Peptidoglycan",
        ["Thermophilican", "Crenarchaeotacan", "Euryarchaeotacan"],
        time: 30,
      ),
      MultipleChoiceQuestion(
        500,
        "The Indial National Harbaria is situated in",
        "Botanical Survey of India (Howrah)",
        [
          "NBRI (Lucknow)",
          "Botanical Garden (NOIDA)",
          "Zoological Survey of India (Kolkota)"
        ],
        time: 25,
      ),
      MultipleChoiceQuestion(
        500,
        "Which of the following botanists associated with phylogenetic classification",
        "Engler and Prantl",
        ["Theophrastus", "Bentham and Hooker", "Linnaeus"],
        time: 25,
      ),
      MultipleChoiceQuestion(
        600,
        "At present time, scientists have named approximately how many species",
        "1,500,000",
        ["1,000,000", "500,000", "2,000,000"],
        time: 20,
      ),
      MultipleChoiceQuestion(
        600,
        "Suffix of order ends with",
        "-ales",
        ["-ae", "-ordae", "-ieae"],
        time: 20,
      ),
    ],
  );
}
