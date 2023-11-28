import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: const Column(
          children: [
            CircleAvatar(
              child: Text(
                "TE",
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "Melisa",
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) => Text('${i}'),
                reverse: true,
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (String text) {},
            decoration: InputDecoration.collapsed(hintText: "Escribe"),
            focusNode: _focusNode,
          )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                  ? CupertinoButton(child: Text('Enviar'), onPressed: () {})
                  : Platform.isAndroid
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: IconButton(
                              onPressed: () {}, icon: Icon(Icons.send)),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: IconButton(
                              onPressed: () {}, icon: Icon(Icons.send_rounded)),
                        ))
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    print("text " + text);
    _focusNode.requestFocus();
    _textController.clear();
  }
}
