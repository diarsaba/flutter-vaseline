import 'package:chatest/widgets/custom_sound_wave.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> paragraphs = [];

  int isOnListen = 0;
  final SoundWaveController soundController = SoundWaveController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("tester"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(child: _iconCenter()
                //buildMessageTextField()
                ),
            SoundWave(
              onStartRecord: () {
                print("record");
              },
              onStopRecord: () {
                soundController.resetAnimation();
              },
              controller: soundController,
            ),
          ],
        )
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _speech.isListening ? _stopListening : _startListening,
        //   tooltip: "Listen",
        //   backgroundColor: _speechEnabled
        //       ? _speech.isNotListening
        //           ? Colors.green
        //           : Colors.red
        //       : Colors.black12,
        //   child: Icon(_speechEnabled
        //       ? _speech.isNotListening
        //           ? Icons.mic_outlined
        //           : Icons.stop_outlined
        //       : Icons.mic_off),
        // ),
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
