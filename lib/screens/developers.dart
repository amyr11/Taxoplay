import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';

import '../components/sidebar.dart';

class DevelopersScreen extends StatelessWidget {
  final int id;
  DevelopersScreen({Key? key, required this.id}) : super(key: key);

  final List<Developer> developers = [
    const Developer(
      imagePath: 'assets/developers/francine.png',
      name: 'Francine Nicole B. Landicho',
    ),
    const Developer(
      imagePath: 'assets/developers/irish.png',
      name: 'Irish D. Ramos',
    ),
    const Developer(
      imagePath: 'assets/developers/mark.png',
      name: 'Mark James O. Diola',
    ),
    const Developer(
      imagePath: 'assets/developers/rhenz.png',
      name: 'Rhenz Marianne I. Hidalgo',
    ),
    const Developer(
      imagePath: 'assets/developers/trisha.png',
      name: 'Trisha Anjela P. Padila',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Developers"),
      ),
      drawer: SideBar(highlighted: id),
      body: buildListView(),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: developers.length,
      itemBuilder: (context, index) => developers[index],
    );
  }
}

class Developer extends StatelessWidget {
  const Developer({
    Key? key,
    required this.imagePath,
    required this.name,
  }) : super(key: key);

  final String imagePath;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultSpace / 2),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: 150,
              image: AssetImage(imagePath),
            ),
            vSpace(kDefaultSpace / 2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
              child: Text(
                name,
                style: k24RegularSecondary,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
