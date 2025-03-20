import 'package:ai_english/core/utils/providers/tts_provider.dart';
import 'package:ai_english/core/utils/providers/tts_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingPanel extends ConsumerStatefulWidget {
  const SettingPanel({
    super.key,
    this.onPlayAll,
    this.showPlayAllButton = true,
    this.showSpeedControl = true,
  });

  final VoidCallback? onPlayAll;
  final bool showPlayAllButton;
  final bool showSpeedControl;

  @override
  ConsumerState<SettingPanel> createState() => _SettingPanelState();
}

class _SettingPanelState extends ConsumerState<SettingPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // 音声スピードを取得
    final speedAsyncValue = ref.watch(ttsSettingsNotifierProvider);

    return speedAsyncValue.when(
      data: (settings) {
        return ExpansionPanelList(
          elevation: 1,
          expandedHeaderPadding: EdgeInsets.zero,
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return const ListTile(
                  title: Text('Controls'),
                );
              },
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('全再生:'),
                        const SizedBox(width: 16),
                        // Play all button
                        ElevatedButton.icon(
                          onPressed: widget.onPlayAll,
                          icon: const Icon(Icons.play_arrow),
                          label: const Text(''),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    // Playback speed control
                    Row(
                      children: [
                        const Text('再生速度:'),
                        Expanded(
                          child: Slider(
                            value: settings.speechRate,
                            min: 0.5,
                            max: 1.5,
                            divisions: 10,
                            label: '${settings.speechRate.toStringAsFixed(1)}x',
                            onChanged: (value) {
                              // 設定プロバイダー経由で音声スピードを更新
                              ref
                                  .read(ttsSettingsNotifierProvider.notifier)
                                  .setSpeechRate(value);

                              ref
                                  .read(ttsNotifierProvider.notifier)
                                  .setSpeechRate(value);
                            },
                          ),
                        ),
                        Text('${settings.speechRate.toStringAsFixed(1)}x'),
                      ],
                    ),
                  ],
                ),
              ),
              isExpanded: _isExpanded,
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Failed to load settings')),
    );
  }
}
