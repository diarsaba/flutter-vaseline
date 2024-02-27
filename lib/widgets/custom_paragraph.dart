import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  final String paragraph;

  const Paragraph({super.key, required this.paragraph});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: SizedBox(
          width: double.infinity,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                paragraph,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}
