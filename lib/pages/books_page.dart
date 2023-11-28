import 'package:chatest/models/books.dart';
import 'package:chatest/widgets/custom_card_books.dart';
import 'package:flutter/material.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<BooksPage> {
  final books = [
    BookStatus(
        title: 'Colores',
        description: 'Las ultimas faces',
        lastedit: '3min ',
        averagetime: '2 h/d',
        image: 'speech-pinguin.jpg',
        words: 100),
    BookStatus(
        title: 'Texturas',
        description: 'Libro sobre colores',
        lastedit: '2min ',
        averagetime: '2 h/d',
        image: 'speech-pinguin.jpg',
        words: 12),
    BookStatus(
        title: 'Facetas',
        description: 'Domde se esconden las cosas del baño',
        lastedit: '13min ',
        averagetime: '2 h/d',
        image: 'speech-pinguin.jpg',
        words: 33),
    BookStatus(
        title: 'Escrituras del Hoy y del Ayer',
        description: 'Libro sobre colores',
        lastedit: '3min ',
        averagetime: '2 h/d',
        image: 'speech-pinguin.jpg',
        words: 4534),
    BookStatus(
        title: 'El libro del timepo',
        description: 'Libro sobre colores',
        lastedit: '43min ',
        averagetime: '2 h/d',
        image: 'speech-pinguin.jpg',
        words: 123),
    BookStatus(
        title: 'Asi como fuere',
        description: 'Libro sobre colores',
        lastedit: '63min ',
        averagetime: '2 h/d',
        image: 'speech-pinguin.jpg',
        words: 42),
    BookStatus(
        title: 'NO me digas mas',
        description: 'Libro sobre colores',
        lastedit: '23min ',
        averagetime: '2 h/d',
        image: 'speech-pinguin.jpg',
        words: 12),
    BookStatus(
        title: 'Este es o no es',
        description: 'Libro sobre colores',
        lastedit: '23min ',
        averagetime: '2 h/d',
        image: 'speech-pinguin.jpg',
        words: 312),
    BookStatus(
        title: 'Así se ven las cosas',
        description: 'Libro sobre colores',
        lastedit: '12min ',
        averagetime: '2 h/d',
        image: 'speech-pinguin.jpg',
        words: 122),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Libros"),
        elevation: 1,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios_new_outlined),
        //   onPressed: () {
        //      Navigator.pushNamed(context, "users");
        //   },
        // ),
        // actions: [
        //   Container(
        //     margin: EdgeInsets.only(right: 10),
        //     child: Icon(
        //       Icons.check_circle,
        //       color: Colors.blue[400],
        //     ),
        //   )
        // ],
      ),
      body: _testList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Add new card");
        },
        tooltip: "Listen",
        backgroundColor: const Color.fromARGB(255, 157, 210, 159),
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView _testList() {
    return ListView.builder(
        itemBuilder: (_, i) => CardBooks(
              book: books[i],
            ),
        itemCount: books.length);
  }
}
