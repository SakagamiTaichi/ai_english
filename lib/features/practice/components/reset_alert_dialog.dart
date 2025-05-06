import 'package:flutter/material.dart';

Widget resetAlertDialog(BuildContext context, Function onReset) {
  return AlertDialog(
    title: const Text('リセットの確認'),
    content: const Text('チャットをリセットしてもよろしいですか？'),
    actions: <Widget>[
      TextButton(
        child: const Text('キャンセル'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text('リセット'),
        onPressed: () {
          onReset();
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
