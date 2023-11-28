import 'package:chatest/models/chapters.dart';
import 'package:chatest/pages/speech_page.dart';
import 'package:flutter/material.dart';

class CardChapter extends StatelessWidget {
  final ChapterStatus chapter;

  const CardChapter({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SpeechPage(chapter: chapter)));
        },
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset(
                  'assets/${chapter.image}',
                  fit: BoxFit.scaleDown,
                  height: 200,
                ),
                Text(
                  chapter.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '"${chapter.description}"',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                Text('Ultima vez editado, hace ${chapter.lastedit}'),
                Text('${chapter.averagetime} dedicada en promedio'),
                Text('${chapter.words} palabras en total'),
              ],
            ),
          ),
        ));
  }
}
