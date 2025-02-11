import 'package:ai_english/features/chat/models/message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tts_provider.g.dart';

@Riverpod(keepAlive: true)
class TtsNotifier extends AsyncNotifier<FlutterTts> {
  @override
  Future<FlutterTts> build() async {
    final tts = FlutterTts();

    // 初期設定
    await tts.setLanguage('en-US');
    await tts.setSpeechRate(0.6);
    await tts.setPitch(1.0);

    await tts.awaitSpeakCompletion(false);
    await tts.awaitSynthCompletion(true);
    await tts.setEngine('com.google.android.tts'); // Multilingual TTS
    // 利用可能な音声を取得
    final voices = await tts.getVoices;
    if (kDebugMode) {
      debugPrint('使用可能なボイス: $voices');
    }

    final engines = await tts.getEngines;
    if (kDebugMode) {
      debugPrint('使用可能なエンジン: $engines');
    }

    ref.onDispose(() {
      tts.stop();
    });

    return tts;
  }

  Future<void> speak(Message message) async {
    final tts = await future;

    // 話者に応じて音声を設定
    if (message.isUser) {
      // 男性ボイスを設定
      await tts.setVoice({
        "name": "en-us-x-tpd-local", // 別の男性ボイス
        "locale": "en-US"
      });
    } else {
      await tts.setVoice({
        "name": "en-us-x-sfg-local", // 別の男性ボイス
        "locale": "en-US"
      });
    }
    await tts.speak(message.text);
  }

  Future<void> speakChatHistory(List<Message> chatHistory) async {
    final tts = await future;

    for (Message message in chatHistory) {
      await speak(message);
      await tts.awaitSpeakCompletion(true);
    }
  }

  Future<void> stop() async {
    final tts = await future;
    await tts.stop();
  }
}
