import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part '../../../generated/core/utils/providers/tts_settings_provider.g.dart';

// TTS設定用のクラス
class TtsSettings {
  final double speechRate;

  const TtsSettings({
    this.speechRate = 1.0,
  });

  // コピーメソッド
  TtsSettings copyWith({
    double? speechRate,
  }) {
    return TtsSettings(
      speechRate: speechRate ?? this.speechRate,
    );
  }
}

// SharedPreferencesのキー
const String _kSpeechRateKey = 'speech_rate';

// TTS設定を保持するグローバルプロバイダー
@Riverpod(keepAlive: true)
class TtsSettingsNotifier extends _$TtsSettingsNotifier {
  @override
  Future<TtsSettings> build() async {
    // SharedPreferencesから設定を読み込む
    final prefs = await SharedPreferences.getInstance();
    final speechRate = prefs.getDouble(_kSpeechRateKey) ?? 1.0;

    return TtsSettings(speechRate: speechRate);
  }

  // 音声スピードを設定するメソッド
  Future<void> setSpeechRate(double rate) async {
    // 値をSharedPreferencesに保存
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_kSpeechRateKey, rate);

    // 状態を更新
    state = AsyncData(state.value!.copyWith(speechRate: rate));
  }
}

// 音声スピードを簡単に取得するための補助プロバイダー
@riverpod
double speechRate(Ref ref) {
  final settingsAsyncValue = ref.watch(ttsSettingsNotifierProvider);
  return settingsAsyncValue.when(
    data: (settings) => settings.speechRate,
    loading: () => 1.0, // デフォルト値
    error: (_, __) => 1.0, // エラー時のデフォルト値
  );
}
