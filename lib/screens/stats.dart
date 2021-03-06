import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:taxoplay/components/buttons.dart';
import 'package:taxoplay/constants.dart';

import '../components/sidebar.dart';
import '../helpers/dialogs.dart';
import '../helpers/sp_helper.dart';
import '../models/category.dart';

class StatsSceen extends StatefulWidget {
  const StatsSceen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<StatsSceen> createState() => _StatsSceenState();
}

class _StatsSceenState extends State<StatsSceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats"),
      ),
      drawer: SideBar(highlighted: widget.id),
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
                              '\$${Category.getStat(histTaxonomy)}',
                              style: k18BoldSecondary,
                            ),
                          ),
                          StatRow(
                            child1: Text(
                              genetics,
                              style: k18RegularWhite,
                            ),
                            child2: Text(
                              '\$${Category.getStat(genetics)}',
                              style: k18BoldSecondary,
                            ),
                          ),
                          StatRow(
                            child1: Text(
                              classification,
                              style: k18RegularWhite,
                            ),
                            child2: Text(
                              '\$${Category.getStat(classification)}',
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
                    onPressed: () {
                      customDialog(
                        context,
                        CoolAlertType.confirm,
                        text: 'This cannot be undone.',
                        onConfirmBtnTap: () {
                          Category.resetBestScores();
                          setState(() {});
                          Navigator.pop(context);
                        },
                      );
                    },
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
    );
  }
}
