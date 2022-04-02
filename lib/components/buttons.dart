import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final bool enabled;

  const DefaultButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
