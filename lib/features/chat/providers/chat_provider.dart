import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/message.dart';

part 'chat_provider.g.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  @override
  List<Message> build() => [];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    // ユーザーのメッセージを追加
    state = [
      ...state,
      Message(
        text: text,
        isUser: true,
        createdAt: DateTime.now(),
      ),
    ];

    // オウム返しレスポンス
    Future.delayed(const Duration(milliseconds: 300), () {
      state = [
        ...state,
        Message(
          text: text,
          isUser: false,
          createdAt: DateTime.now(),
        ),
      ];
    });
  }
}
