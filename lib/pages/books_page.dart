import 'package:chatest/models/bookinfo.dart';
import 'package:chatest/widgets/custom_card_books.dart';
import 'package:chatest/widgets/custom_input.dart';
import 'package:chatest/widgets/custom_list_dismiss.dart';
import 'package:chatest/widgets/custom_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<BooksPage> {
  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final LocalStorage storage = LocalStorage('books_info.json');
  List<BookInfo> books = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Libros"),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "login");
          },
          child: Text(
            "salir",
            style: TextStyle(color: Colors.blue[400]),
          ),
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings_outlined,
                ),
              ))
        ],
      ),
      body: FutureBuilder(
        future: storage.ready,
        builder: (_, AsyncSnapshot snapshot) {
          var items = storage.getItem('_book_list_');

          if (items != null) {
            books = List<BookInfo>.from(
              (items as List).map(
                (item) => BookInfo.fromJson(item),
              ),
            );
          }
          return books.isNotEmpty
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
                        books[i].title,
                        () {
                          setState(() {});
                        },
                        "No",
                        () {
                          books.removeAt(i);
                          saveBooks();
                          setState(() {});
                        },
                        "Si");
                  },
                  onLeft: (i) {
                    showDialogSimple(context, "¿Archivar?", books[i].title,
                        () {}, "No", () {}, "Si");
                  },
                  childIndex: (i) {
                    return CardBooks(book: books[i]);
                  },
                  list: books)
              : _iconCenter();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Nuevo Libro'),
              content: SizedBox(
                height: 150,
                child: Column(
                  children: [
                    CustomInput(
                        icon: Icons.title_outlined,
                        placeholder: "Nombre del Libro",
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
                    books.add(
                      BookInfo(
                          title: titleCtrl.text,
                          description: descriptionCtrl.text,
                          timestamp: DateTime.timestamp().toString(),
                          //timeaverage: [],
                          image: 'speech-pinguin.jpg',
                          words: 0),
                    );

                    saveBooks();

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
        Icons.book_rounded,
        size: 200,
        color: Colors.black38,
      ),
    );
  }

  void saveBooks() {
    var list = books.map((item) {
      return item.toJson();
    }).toList();

    storage.setItem("_book_list_", list);
  }
}
