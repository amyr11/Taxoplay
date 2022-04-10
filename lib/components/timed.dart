import 'package:flutter/material.dart';

class Timed extends StatefulWidget {
  const Timed({Key? key, required this.time}) : super(key: key);

  final int time;

  @override
  TimedState createState() => TimedState();
}

class TimedState<T extends Timed> extends State<T> {
  late final bool timed;

  @override
  void initState() {
    super.initState();
    timed = widget.time > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
