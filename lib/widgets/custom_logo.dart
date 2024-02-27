import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Image(
            image: AssetImage('assets/speech-pinguin.jpg'),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }
}
