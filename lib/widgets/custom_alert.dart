import 'package:chatest/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class AlertDialogS extends StatefulWidget {
  const AlertDialogS(
      {super.key,
      required this.onConfirm,
      required this.title,
      required this.placeholder1,
      required this.placeholder2});
  final Function(String, String) onConfirm;
  final String title;
  final String placeholder1;
  final String placeholder2;
  @override
  State<AlertDialogS> createState() => _AlertDialogSState();
}

class _AlertDialogSState extends State<AlertDialogS> {
  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      title: Text(widget.title),
      content: Wrap(
        children: [
          CustomInput(
            icon: Icons.title_outlined,
            placeholder: widget.placeholder1,
            textcontroller: titleCtrl,
            onChanged: (v) {
              setState(() {});
            },
          ),
          CustomInput(
            icon: Icons.description_outlined,
            placeholder: widget.placeholder2,
            textcontroller: descriptionCtrl,
            onChanged: (v) {
              setState(() {});
            },
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Row(
                children: [
                  Icon(Icons.highlight_remove_outlined),
                  Text(" · Descartar")
                ],
              ),
            ),
            TextButton(
              onPressed:
                  titleCtrl.text.isNotEmpty && descriptionCtrl.text.isNotEmpty
                      ? () {
                          Navigator.pop(context, 'OK');
                          widget.onConfirm(titleCtrl.text, descriptionCtrl.text);
                        }
                      : null,
              child: const Row(
                children: [Icon(Icons.save_outlined), Text(" · Guardar")],
              ),
            ),
          ],
        )
      ],
    );
  }
}
