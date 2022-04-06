import 'package:flutter/material.dart';
import 'package:taxoplay/constants.dart';
import 'package:taxoplay/helpers/empty_space.dart';

class LogoWithText extends StatelessWidget {
  const LogoWithText({
    Key? key,
    required this.header,
    required this.body,
  }) : super(key: key);

  final String header;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 145,
              image: AssetImage('assets/logo/logo.png'),
            ),
            vSpace(kDefaultSpace / 2),
            Text(
              header,
              style: k24RegularSecondary,
            ),
            vSpace(kDefaultSpace / 4),
            Text(
              body,
              style: k18RegularWhite,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
