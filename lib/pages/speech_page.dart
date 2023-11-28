import 'dart:convert';

import 'package:chatest/models/chapters.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key, required this.chapter});

  final ChapterStatus chapter;

  @override
  State<SpeechPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<SpeechPage> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _wordsSpoken = "";
  double _confidenceLevel = 0;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _confidenceLevel = 0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;

      // here try to convert the new text
      _completion(result.recognizedWords);
    });
  }

  void _completion(String prompt) async {

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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'
      },
      body: jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content":
                  'Translate the following Spanish text to English: "Las mañanas empiezan con la luz del sol."'
            }
          ]
        },
      ),
    );

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.chapter.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(_speechToText.isListening
                ? "listen..."
                : _speechEnabled
                    ? "Tap micro"
                    : "not avalible"),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _wordsSpoken,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            if (_speechToText.isNotListening && _confidenceLevel > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Text(
                  "Confidence ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w200),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speechToText.isListening ? _stopListening : _startListening,
        tooltip: "Listen",
        backgroundColor: Colors.green,
        child: Icon(_speechToText.isNotListening
            ? Icons.mic_off_outlined
            : Icons.mic_outlined),
      ),
    );
  }
}
