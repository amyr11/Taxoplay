import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/constants.dart';

import '../components/sidebar.dart';
import '../helpers/sp_helper.dart';

class StatsSceen extends StatelessWidget {
  const StatsSceen({Key? key, required this.id}) : super(key: key);

  final int id;
  final String histTaxonomy = 'History of Taxonomy';
  final String genetics = 'Genetics';
  final String classification = 'Classification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats"),
      ),
      drawer: SideBar(highlighted: id),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Image(
                      height: 150,
                      image: AssetImage('assets/logo/logo.png'),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StatRow(
                            child1: Text(
                              'CATEGORY',
                              style: k12BoldPrimaryLight,
                            ),
                            child2: Text(
                              'BEST',
                              style: k12BoldPrimaryLight,
                            ),
                          ),
                          StatRow(
                            child1: Text(
                              histTaxonomy,
                              style: k18RegularWhite,
                            ),
                            child2: Text(
                              '\$${SPHelper.sp.getInt(histTaxonomy)}',
                              style: k18BoldSecondary,
                            ),
                          ),
                          StatRow(
                            child1: Text(
                              genetics,
                              style: k18RegularWhite,
                            ),
                            child2: Text(
                              '\$${SPHelper.sp.getInt(genetics)}',
                              style: k18BoldSecondary,
                            ),
                          ),
                          StatRow(
                            child1: Text(
                              classification,
                              style: k18RegularWhite,
                            ),
                            child2: Text(
                              '\$${SPHelper.sp.getInt(classification)}',
                              style: k18BoldSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  DefaultButton(
                    onPressed: () {},
                    text: 'Reset',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StatRow extends StatelessWidget {
  const StatRow({
    Key? key,
    required this.child1,
    required this.child2,
  }) : super(key: key);

  final Widget child1;
  final Widget child2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Flexible(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: child1,
            ),
            Expanded(
              child: child2,
            ),
          ],
        ),
      ),
    );
  }
}
