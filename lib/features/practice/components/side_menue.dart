import 'package:ai_english/core/utils/providers/tts_provider.dart';
import 'package:ai_english/core/utils/providers/tts_settings_provider.dart';
import 'package:ai_english/features/practice/pages/enjglish_recall_test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class SideMenu extends ConsumerWidget {
  final VoidCallback? onPlayAll;
  final String? conversationId;
  final bool showPlayAllButton;
  final bool showSpeedControl;
  final bool showTestButton;

  const SideMenu({
    super.key,
    this.conversationId,
    this.onPlayAll,
    this.showPlayAllButton = true,
    this.showSpeedControl = true,
    this.showTestButton = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 音声スピードを取得
    final speedAsyncValue = ref.watch(ttsSettingsNotifierProvider);

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: speedAsyncValue.when(
                  data: (settings) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showTestButton && conversationId != null) ...[
                          Text(
                            'テスト',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: EnglishRecallTestPage(
                                    conversationId: conversationId!,
                                  ),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('テスト'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                        if (showPlayAllButton && onPlayAll != null) ...[
                          Text(
                            '全再生',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: onPlayAll,
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('全てのメッセージを再生'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                        if (showSpeedControl) ...[
                          Text(
                            '再生速度',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text('0.5x'),
                              Expanded(
                                child: Slider(
                                  value: settings.speechRate,
                                  min: 0.5,
                                  max: 1.5,
                                  divisions: 10,
                                  label:
                                      '${settings.speechRate.toStringAsFixed(1)}x',
                                  onChanged: (value) {
                                    // 設定プロバイダー経由で音声スピードを更新
                                    ref
                                        .read(ttsSettingsNotifierProvider
                                            .notifier)
                                        .setSpeechRate(value);

                                    ref
                                        .read(ttsNotifierProvider.notifier)
                                        .setSpeechRate(value);
                                  },
                                ),
                              ),
                              const Text('1.5x'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              '現在: ${settings.speechRate.toStringAsFixed(1)}x',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, __) =>
                      const Center(child: Text('Failed to load settings')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
