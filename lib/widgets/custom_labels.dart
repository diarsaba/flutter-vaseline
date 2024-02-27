import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String title;
  final String subtitle;

  const Labels(
      {super.key,
      required this.ruta,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300),
        ),
        GestureDetector(
          child: Text(
            subtitle,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, ruta);
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
