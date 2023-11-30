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
                  'assets/${book.image}',
                  fit: BoxFit.scaleDown,
                  height: 200,
                ),
                Text(
                  book.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '"${book.description}"',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                // Text('Ultima vez editado, hace ${book.timestamp}'),
                // Text('${book.timeaverage} dedicada en promedio'),
                Text('${book.words} palabras en total'),
              ],
            ),
          ),
        ));
  }
}

// Card(
//             child: Container(
//               height: 100,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage('assets/${this.book.image}'))),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Text(this.book.title),
//               ),
//             ),
//             margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
//           )

// Card(
//           child: Wrap(
//             children: [
//               Container(
//                 height: 144,
//                 width: 500,
//                 //color: Colors.orange,
//                 child: Image(
//                   image: AssetImage('assets/${this.book.image}'),
//                 ),
//               ),
//               Container(
//                 child: Column(children: [Text(this.book.title),
//                 Text(this.book.title)]),
//               )
//             ],
//           ),
//         ),