import 'package:flutter/material.dart';

void showDialogSimple(
    BuildContext context,
    String message,
    String description,
    VoidCallback onCancel,
    String cancelMessage,
    VoidCallback onConfirm,
    String confirmMessage) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(message),
      content: Text(
          description,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              onCancel();
            },
            child: Text(cancelMessage)),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(confirmMessage)),
      ],
    ),
  );
}
