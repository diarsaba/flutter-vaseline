//import 'dart:convert';

import 'package:chatest/models/chapters.dart';
import 'package:chatest/widgets/custom_paragraph.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:speech_to_text/speech_to_text.dart';
//import 'package:http/http.dart' as http;

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key, required this.chapter});

  final Chapters chapter;

  @override
  State<SpeechPage> createState() => _ChatPageState(chapter: chapter);
}

class _ChatPageState extends State<SpeechPage> {
  final Chapters chapter;
  final SpeechToText _speech = SpeechToText();
  final LocalStorage storage = LocalStorage('paragraphs.json');

  _ChatPageState({required this.chapter});

  bool _speechEnabled = false;
  String _wordsSpoken = "";

  List<String> paragraphs = [];
  int paragraphs_len = 0;
  bool isEdited = false;

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    try {
      _speechEnabled = await _speech.initialize();
      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  void _startListening() async {
    await _speech.listen(onResult: _onSpeechResult);
    paragraphs.add("");

    setState(() {});
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    _wordsSpoken = "${result.recognizedWords}";
    paragraphs.last = _wordsSpoken;
    isEdited = true;
    setState(() {});
  }

  void _saveData() async {
    if (paragraphs_len != paragraphs.length || isEdited == true) {
      await storage.setItem('${chapter.title}_paragraph', paragraphs);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapter.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            _saveData();
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: storage.ready,
        builder: (_, AsyncSnapshot snapshot) {
          if (paragraphs.isEmpty) {
            var items = storage.getItem('${chapter.title}_paragraph');
            if (items != null) {
              paragraphs = List<String>.from(
                (items as List).map(
                  (item) => item,
                ),
              );
            }
            paragraphs_len = paragraphs.length;
          }

          return paragraphs.isNotEmpty ? _paragraphList() : _iconCenter();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speech.isListening ? _stopListening : _startListening,
        tooltip: "Listen",
        backgroundColor: _speechEnabled
            ? _speech.isNotListening
                ? Colors.green
                : Colors.red
            : Colors.black12,
        child: Icon(_speechEnabled
            ? _speech.isNotListening
                ? Icons.mic_outlined
                : Icons.stop_outlined
            : Icons.mic_off),
      ),
    );
  }

  ListView _paragraphList() {
    return ListView.builder(
      itemBuilder: (context, i) {
        final item = paragraphs[i];
        return Dismissible(
          key: Key(item.toString()),
          onDismissed: (direction) {
            setState(() {
              paragraphs.removeAt(i);
              isEdited = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(' dismissed'),
              ),
            );
          },
          child: Paragraph(
            paragraph: paragraphs[i],
          ),
        );
      },
      itemCount: paragraphs.length,
    );
  }

  Center _iconCenter() {
    return const Center(
      child: Icon(
        Icons.text_rotation_angleup_outlined,
        size: 200,
        color: Colors.black38,
      ),
    );
  }
}


  // void _completion(String prompt) async {

  //   final response = await http.post(
  //     Uri.parse('https://api.openai.com/v1/completions'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //           'Bearer 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'
  //     },
  //     body: jsonEncode(
  //       {
  //         "model": "gpt-3.5-turbo",
  //         "messages": [
  //           {
  //             "role": "user",
  //             "content":
  //                 'Translate the following Spanish text to English: "Las mañanas empiezan con la luz del sol."'
  //           }
  //         ]
  //       },
  //     ),
  //   );

  // }