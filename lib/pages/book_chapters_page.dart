
import 'package:chatest/models/books.dart';
import 'package:chatest/models/chapters.dart';
import 'package:chatest/widgets/custom_card_chapter.dart';
import 'package:flutter/material.dart';

class ChaptersPage extends StatefulWidget {
  const ChaptersPage({super.key, required this.book});
  final BookStatus book;

  @override
  State<ChaptersPage> createState() => _ChaptesPageState();
}

class _ChaptesPageState extends State<ChaptersPage> {
  final chapters = [
    ChapterStatus(
        title: 'Colores',
        description: 'Las ultimas faces',
        lastedit: '3min ',
        averagetime: '2 h/d',
        image: 'writing-pinguin.jpg',
        words: 100),
    ChapterStatus(
        title: 'Texturas',
        description: 'Libro sobre colores',
        lastedit: '2min ',
        averagetime: '2 h/d',
        image: 'writing-pinguin.jpg',
        words: 12),
    ChapterStatus(
        title: 'Facetas',
        description: 'Domde se esconden las cosas del baño',
        lastedit: '13min ',
        averagetime: '2 h/d',
        image: 'writing-pinguin.jpg',
        words: 33),
    ChapterStatus(
        title: 'Escrituras del Hoy y del Ayer',
        description: 'Libro sobre colores',
        lastedit: '3min ',
        averagetime: '2 h/d',
        image: 'writing-pinguin.jpg',
        words: 4534),
    ChapterStatus(
        title: 'El libro del timepo',
        description: 'Libro sobre colores',
        lastedit: '43min ',
        averagetime: '2 h/d',
        image: 'writing-pinguin.jpg',
        words: 123),
    ChapterStatus(
        title: 'Asi como fuere',
        description: 'Libro sobre colores',
        lastedit: '63min ',
        averagetime: '2 h/d',
        image: 'writing-pinguin.jpg',
        words: 42),
    ChapterStatus(
        title: 'NO me digas mas',
        description: 'Libro sobre colores',
        lastedit: '23min ',
        averagetime: '2 h/d',
        image: 'writing-pinguin.jpg',
        words: 12),
    ChapterStatus(
        title: 'Este es o no es',
        description: 'Libro sobre colores',
        lastedit: '23min ',
        averagetime: '2 h/d',
        image: 'writing-pinguin.jpg',
        words: 312),
    ChapterStatus(
        title: 'Así se ven las cosas',
        description: 'Libro sobre colores',
        lastedit: '12min ',
        averagetime: '2 h/d',
        image: 'writing-pinguin.jpg',
        words: 122),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pushNamed(context, "users");
          },
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.sort_outlined),
              ))
        ],
      ),
      body: _TestList(),
    );
  }

  ListView _TestList() {
    return ListView.builder(
      itemBuilder: (_, i) => CardChapter(
        chapter: chapters[i],
      ),
      itemCount: chapters.length,
      reverse: true,
    );
  }

  // ListView _ListViewUsers() {
  //   return ListView.separated(
  //       physics: BouncingScrollPhysics(),
  //       itemBuilder: (_, i) => _userListTile(usuarios[i]),
  //       separatorBuilder: (_, i) => Divider(),
  //       itemCount: usuarios.length);
  // }

  // ListTile _userListTile(Usuario user) {
  //   return ListTile(
  //     title: Text(user.nombre),
  //     subtitle: Text(user.email),
  //     leading: CircleAvatar(
  //       child: Text(user.nombre.substring(0, 2)),
  //     ),
  //     trailing: Container(
  //       width: 10,
  //       height: 10,
  //       decoration: BoxDecoration(
  //           color: user.online ? Colors.green[300] : Colors.red,
  //           borderRadius: BorderRadius.circular(100)),
  //     ),
  //   );
  // }
}
