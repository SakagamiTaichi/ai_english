import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:ai_english/core/http/api_client.dart';
import 'package:ai_english/core/utils/provider/tts_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/message.dart';

part 'chat_provider.g.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  late final ApiClient _apiClient;

  @override
  List<Message> build() {
    _apiClient = ApiClient();
    return [];
  }

  Future<void> sendMessage(String text, {String sessionId = "default"}) async {
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

    try {
      // 空の応答メッセージを追加（ストリーミング用）
      final responseMessage = Message(
        text: "",
        isUser: false,
        createdAt: DateTime.now(),
      );
      state = [...state, responseMessage];

      // APIからストリーミングレスポンスを取得
      final response = await _apiClient.getStream(
        '/english/chat',
        queryParameters: {
          'message': text,
          'session_id': sessionId,
        },
      );

      // ResponseBodyをStreamに変換
      final stream = (response.data as ResponseBody).stream;

      // UTF8デコーダーの準備
      final transformer = StreamTransformer<Uint8List, String>.fromHandlers(
        handleData: (data, sink) {
          sink.add(utf8.decode(data));
        },
      );

      // ストリームの処理
      await for (final chunk in stream.transform(transformer)) {
        for (final line in chunk.split('\n')) {
          if (line.startsWith('data: ')) {
            try {
              final jsonData = json.decode(line.substring(6));
              if (jsonData['content'] != null) {
                // 最後のメッセージを更新
                final updatedState = [...state];
                updatedState.last = Message(
                  text: updatedState.last.text + jsonData['content'],
                  isUser: false,
                  createdAt: responseMessage.createdAt,
                );
                state = updatedState;
              }
            } catch (e) {
              debugPrint('Error parsing SSE data: $e');
            }
          }
        }
      }

      // 完成したメッセージを読み上げ
      if (state.last.text.isNotEmpty) {
        await ref.read(ttsNotifierProvider.notifier).speak(state.last.text);
      }
    } catch (e) {
      // エラーメッセージを追加
      state = [
        ...state,
        Message(
          text: "エラーが発生しました: $e",
          isUser: false,
          createdAt: DateTime.now(),
        ),
      ];
    }
  }
}
