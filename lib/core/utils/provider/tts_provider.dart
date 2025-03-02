import 'package:ai_english/core/utils/provider/tts_settings_provider.dart'; // 新しいプロバイダーをインポート
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

    // 保存されている音声スピードを取得して設定
    final settings = await ref.watch(ttsSettingsNotifierProvider.future);
    await tts.setSpeechRate(settings.speechRate / 2); // 実際のTTSエンジンに適用する値を調整

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

    // 設定が変更されたときに再設定するリスナーを追加
    ref.listen(ttsSettingsNotifierProvider, (previous, next) {
      next.whenData((settings) async {
        await tts.setSpeechRate(settings.speechRate / 2);
      });
    });

    ref.onDispose(() {
      tts.stop();
    });

    return tts;
  }

  // 音声スピードを変更するメソッド
  Future<void> setSpeechRate(double rate) async {
    // 設定プロバイダーを通じて音声スピードを更新
    await ref.read(ttsSettingsNotifierProvider.notifier).setSpeechRate(rate);

    // TTSエンジンに直接適用
    final tts = await future;
    await tts.setSpeechRate(rate / 2.25);
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
