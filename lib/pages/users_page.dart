import 'package:chatest/models/books.dart';
import 'package:chatest/widgets/custom_card_books.dart';
import 'package:flutter/material.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);

final books = [
    BookStatus(title: 'Colores', description: 'Las ultimas faces', lastedit: '3min ', averagetime: '2 h/d', image: 'speech-pinguin.jpg', words: 100),
    BookStatus(title: 'Texturas', description: 'Libro sobre colores', lastedit: '2min ', averagetime: '2 h/d', image: 'speech-pinguin.jpg', words: 12),
    BookStatus(title: 'Facetas', description: 'Domde se esconden las cosas del baño', lastedit: '13min ', averagetime: '2 h/d', image: 'speech-pinguin.jpg', words: 33),
    BookStatus(title: 'Escrituras del Hoy y del Ayer', description: 'Libro sobre colores', lastedit: '3min ', averagetime: '2 h/d', image: 'speech-pinguin.jpg', words: 4534),
    BookStatus(title: 'El libro del timepo', description: 'Libro sobre colores', lastedit: '43min ', averagetime: '2 h/d', image: 'speech-pinguin.jpg', words: 123),
    BookStatus(title: 'Asi como fuere', description: 'Libro sobre colores', lastedit: '63min ', averagetime: '2 h/d', image: 'speech-pinguin.jpg', words: 42),
    BookStatus(title: 'NO me digas mas', description: 'Libro sobre colores', lastedit: '23min ', averagetime: '2 h/d', image: 'speech-pinguin.jpg', words: 12),
    BookStatus(title: 'Este es o no es', description: 'Libro sobre colores', lastedit: '23min ', averagetime: '2 h/d', image: 'speech-pinguin.jpg', words: 312),
    BookStatus(title: 'Así se ven las cosas', description: 'Libro sobre colores', lastedit: '12min ', averagetime: '2 h/d', image: 'speech-pinguin.jpg', words: 122),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("mis libros"),
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
      body: _TestList(),
      // body: SmartRefresher(
      //   controller: _refreshController,
      //   enablePullDown: true,
      //   onRefresh: _LoadUsers(),
      //   child: _ListViewUsers(),
      // ),
    );
  }

  ListView _TestList() {
    return ListView.builder(
        itemBuilder: (_, i) =>CardBooks(book: books[i],),
        itemCount: books.length);
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

  // _LoadUsers() async {
  //   await Future.delayed(Duration(microseconds: 1000));
  //   _refreshController.refreshCompleted();
  // }
}
