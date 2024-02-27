import 'package:chatest/models/chapters.dart';
import 'package:chatest/pages/speech_page.dart';
import 'package:flutter/material.dart';

class CardChapter extends StatelessWidget {
  final Chapters chapter;

  const CardChapter({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpeechPage(chapter: chapter),
            ),
          );
        },
        child: SizedBox(
          width: double.infinity,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    chapter.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '"${chapter.description}"',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  Text('${chapter.words} palabras en total'),
                ],
              ),
            ),
          ),
        ));
  }
}
