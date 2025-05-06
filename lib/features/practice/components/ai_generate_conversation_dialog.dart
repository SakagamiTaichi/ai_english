import 'package:flutter/material.dart';

Widget aiGenerateDialog(BuildContext context) {
  final TextEditingController _phraseController = TextEditingController();
  return AlertDialog(
    title: const Text('フレーズからAI生成'),
    // テキストボックスを表示 - 複数行入力対応
    content: TextField(
      controller: _phraseController,
      decoration: const InputDecoration(
        hintText: '英語でフレーズを入力してください。',
        // border: OutlineInputBorder(),
      ),
      maxLines: null, // 複数行入力を可能にする
      minLines: 3, // 初期表示の行数
      keyboardType: TextInputType.multiline, // 複数行入力用のキーボードタイプ
    ),
    actions: [
      TextButton(
        child: const Text('キャンセル'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('生成'),
      ),
    ],
  );
}
