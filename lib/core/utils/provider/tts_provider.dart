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

    ref.onDispose(() {
      tts.stop();
    });

    return tts;
  }

  Future<void> speak(String text) async {
    final tts = await future;
    await tts.speak(text);
  }

  Future<void> speakChatHistory(List<String> chatHistory) async {
    final tts = await future;
    for (String message in chatHistory) {
      await tts.speak(message);
      await tts.awaitSpeakCompletion(true);
    }
  }

  Future<void> pause() async {
    final tts = await future;
    await tts.pause();
  }

  Future<void> resume() async {
    final tts = await future;
    await tts.resume();
  }

  Future<void> stop() async {
    final tts = await future;
    await tts.stop();
  }

  Future<void> setPlaybackPosition(double position) async {
    final tts = await future;
    await tts.setProgress(position);
  }
}
