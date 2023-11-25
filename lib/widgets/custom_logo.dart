import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/speech-pinguin.jpg'),
            ),
            Text(
              this.title,
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
