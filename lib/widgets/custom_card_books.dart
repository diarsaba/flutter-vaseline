import 'package:chatest/models/bookinfo.dart';
import 'package:chatest/pages/book_chapters_page.dart';

import 'package:flutter/material.dart';

class CardBooks extends StatelessWidget {
  final BookInfo book;

  const CardBooks({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChaptersPage(
                        book: book,
                      )));
        },
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset(
                      'assets/speech-pinguin.jpg',
                      fit: BoxFit.scaleDown,
                      height: 150,
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          book.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            '"${book.description}"',
                            style: const TextStyle(fontStyle: FontStyle.italic),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Text('Ultima vez editado, hace ${book.timestamp}'),
                        // Text('${book.timeaverage} dedicada en promedio'),
                        Text('${book.words} palabras en total'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
