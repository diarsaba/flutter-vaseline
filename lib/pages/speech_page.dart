import 'dart:async';

import 'package:chatest/models/chapters.dart';
import 'package:chatest/widgets/custom_list_dismiss.dart';
import 'package:chatest/widgets/custom_paragraph.dart';
import 'package:chatest/widgets/custom_show_dialog.dart';
import 'package:chatest/widgets/custom_sound_wave.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:speech_to_text/speech_to_text.dart';
//import 'package:http/http.dart' as http;

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key, required this.chapter});

  final Chapters chapter;

  @override
  State<SpeechPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<SpeechPage> {
  final SpeechToText _speech = SpeechToText();
  final LocalStorage storage = LocalStorage('paragraphs.json');

  final ScrollController _controller = ScrollController();
  final SoundWaveController soundController = SoundWaveController();
  bool _speechEnabled = false;
  String _wordsSpoken = "";

  List<String> paragraphs = [];

  int isOnListen = 0;

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
    paragraphs.insert(0, "");
    isOnListen += 1;
    autoSave();
    setState(() {});
  }

  void autoSave() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      if (_speech.isListening == false) {
        soundController.resetAnimation();
        isOnListen = 0;
        //vamos a guardar
        await storage.setItem('${widget.chapter.title}_paragraph', paragraphs);
      } else if (isOnListen > 1) {
        //Hubo un solapamiento
        //hay que guardar
        autoSave();
      } else {
        autoSave();
      }
    });
  }

  void _stopListening() async {
    await _speech.stop();
    soundController.resetAnimation();
    setState(() {});
  }

  void _onSpeechResult(result) {
    _wordsSpoken = "${result.recognizedWords}";
    paragraphs.first = _wordsSpoken;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.chapter.title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: storage.ready,
                builder: (_, AsyncSnapshot snapshot) {
                  if (paragraphs.isEmpty) {
                    var items =
                        storage.getItem('${widget.chapter.title}_paragraph');
                    if (items != null) {
                      paragraphs = List<String>.from(
                        (items as List).map(
                          (item) => item,
                        ),
                      );
                    }
                  }
                  return paragraphs.isNotEmpty
                      ? ListDismiss(
                          reverse: true,
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
                                paragraphs[i].length < 100
                                    ? paragraphs[i]
                                    : '${paragraphs[i].substring(0, 100)}...',
                                () {
                                  setState(() {});
                                },
                                "No",
                                () {
                                  paragraphs.removeAt(i);
                                  autoSave();
                                  setState(() {});
                                },
                                "Si");
                          },
                          direction: DismissDirection.startToEnd,
                          onLeft: (i) {
                            showDialogSimple(
                                context,
                                "¿Archivar?",
                                paragraphs[i].substring(0, 20),
                                () {},
                                "No",
                                () {},
                                "Si");
                          },
                          childIndex: (i) {
                            return Paragraph(paragraph: paragraphs[i]);
                          },
                          list: paragraphs)
                      : _iconCenter();
                },
              ),
              //buildMessageTextField()
            ),
            SoundWave(
              onStartRecord: () {
                _startListening();
              },
              onStopRecord: () {
                _stopListening();
              },
              controller: soundController,
            ),
          ],
        ));
  }

  // ListView _paragraphList() {
  //   return ListView.builder(
  //     itemCount: paragraphs.length,
  //     itemBuilder: (context, i) {
  //       return Dismissible(
  //         background: Container(
  //           color: Colors.red,
  //           child: const Icon(Icons.delete),
  //         ),
  //         key: UniqueKey(),
  //         onDismissed: (direction) => deleteConfirmation(i),
  //         child: Paragraph(
  //           paragraph: paragraphs[i],
  //         ),
  //       );
  //     },
  //     controller: _controller,
  //     reverse: true,
  //   );
  // }

  Center _iconCenter() {
    return const Center(
      child: Icon(
        Icons.text_rotation_angleup_outlined,
        size: 200,
        color: Colors.black38,
      ),
    );
  }

  void deleteConfirmation(int index) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('¿Eliminar?'),
        content: SizedBox(
          height: 150,
          child: Text(paragraphs[index]),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Row(
              children: [Icon(Icons.cancel_outlined), Text("NO")],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              paragraphs.removeAt(index);
              autoSave();
              setState(() {});
            },
            child: const Row(
              children: [Icon(Icons.save_outlined), Text("SI")],
            ),
          ),
        ],
      ),
    );
  }
}
