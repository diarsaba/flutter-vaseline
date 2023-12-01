import 'package:chatest/models/bookinfo.dart';
import 'package:chatest/models/chapters.dart';
import 'package:chatest/widgets/custom_card_chapter.dart';
import 'package:chatest/widgets/custom_input.dart';
import 'package:chatest/widgets/custom_list_dismiss.dart';
import 'package:chatest/widgets/custom_show_dialog.dart';
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
            Navigator.pop(context);
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
          return chapters.isNotEmpty
              ? ListDismiss(
                  rightIcon: const Icon(
                    Icons.delete_rounded,
                    size: 40,
                    color: Colors.red,
                  ),
                  leftIcon: const Icon(
                    Icons.archive_outlined,
                    size: 40,
                    color: Colors.green,
                  ),
                  onRight: (i) {
                    showDialogSimple(
                        context,
                        "¿Eliminar?",
                        chapters[i].title,
                        () {
                          setState(() {});
                        },
                        "No",
                        () {
                          chapters.removeAt(i);
                          saveChapters();
                          setState(() {});
                        },
                        "Si");
                  },
                  onLeft: (i) {
                    showDialogSimple(context, "¿Archivar?", chapters[i].title,
                        () {}, "No", () {}, "Si");
                  },
                  childIndex: (i) {
                    return CardChapter(chapter: chapters[i]);
                  },
                  list: chapters)
              : _iconCenter();
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

                    saveChapters();
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

  Center _iconCenter() {
    return const Center(
      child: Icon(
        Icons.book,
        size: 200,
        color: Colors.black38,
      ),
    );
  }

  void saveChapters() {
    var list = chapters.map((item) {
      return item.toJson();
    }).toList();

    storage.setItem('${widget.book.title}_chapters_', list);
  }
}
