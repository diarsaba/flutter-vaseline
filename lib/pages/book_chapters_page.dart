import 'package:chatest/models/bookinfo.dart';
import 'package:chatest/models/chapters.dart';
import 'package:chatest/widgets/custom_card_chapter.dart';
import 'package:chatest/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ChaptersPage extends StatefulWidget {
  const ChaptersPage({super.key, required this.book});
  final BookInfo book;

  @override
  State<ChaptersPage> createState() => _ChaptesPageState();
}

class _ChaptesPageState extends State<ChaptersPage> {
  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final LocalStorage storage = LocalStorage('chapters_info.json');
  List<Chapters> chapters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('· ${widget.book.title}'),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pushNamed(context, "books");
          },
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.sort_outlined),
              ))
        ],
      ),
      body: FutureBuilder(
        future: storage.ready,
        builder: (_, AsyncSnapshot snapshot) {
          var items = storage.getItem('${widget.book.title}_chapters_');

          if (items != null) {
            chapters = List<Chapters>.from(
              (items as List).map(
                (item) => Chapters.fromJson(item),
              ),
            );
          }
          return chapters.isNotEmpty ? _chapterList() : _iconCenter();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Nuevo Capitulo'),
              content: SizedBox(
                height: 150,
                child: Column(
                  children: [
                    CustomInput(
                        icon: Icons.title_outlined,
                        placeholder: "Nombre del Capitulo",
                        textcontroller: titleCtrl),
                    CustomInput(
                        icon: Icons.description_outlined,
                        placeholder: "De que trata?",
                        textcontroller: descriptionCtrl),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  //child: const Text('Descartar'),
                  child: const Row(
                    children: [
                      Icon(Icons.highlight_remove_outlined),
                      Text(" · Descartar")
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    chapters.add(
                      Chapters(
                          title: titleCtrl.text,
                          description: descriptionCtrl.text,
                          timestamp: DateTime.timestamp().toString(),
                          //timeaverage: [],
                          words: 0),
                    );
                    var list = chapters.map((item) {
                      return item.toJson();
                    }).toList();

                    storage.setItem('${widget.book.title}_chapters_', list);

                    titleCtrl.clear();
                    descriptionCtrl.clear();

                    setState(() {});
                  },
                  child: const Row(
                    children: [Icon(Icons.save_outlined), Text(" · Guardar")],
                  ),
                ),
              ],
            ),
          );
        },
        tooltip: "Listen",
        backgroundColor: const Color.fromARGB(255, 157, 210, 159),
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView _chapterList() {
    return ListView.builder(
      itemBuilder: (_, i) => CardChapter(
        chapter: chapters[i],
      ),
      itemCount: chapters.length,
    );
  }

  Center _iconCenter() {
    return const Center(
      child: Icon(
        Icons.book,
        size: 200,
        color: Colors.black38,
      ),
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
