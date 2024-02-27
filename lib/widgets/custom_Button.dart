import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonBlue({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, foregroundColor: Colors.white),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
