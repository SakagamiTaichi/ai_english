import 'package:flutter/material.dart';

Widget resetAlertDialog(BuildContext context, Function onReset) {
  return AlertDialog(
    title: const Text('Confirm Reset'),
    content: const Text('Are you sure you want to reset the chat?'),
    actions: <Widget>[
      TextButton(
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text('Reset'),
        onPressed: () {
          onReset();
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
