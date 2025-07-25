import 'package:ai_english/core/components/error_feedback.dart';
import 'package:ai_english/features/practice/providers/conversation_set_provider.dart';
import 'package:ai_english/features/practice/providers/conversations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AiGenerateDialog extends ConsumerStatefulWidget {
  const AiGenerateDialog({super.key});

  @override
  ConsumerState<AiGenerateDialog> createState() => _AiGenerateDialogState();
}

class _AiGenerateDialogState extends ConsumerState<AiGenerateDialog> {
  final TextEditingController _phraseController = TextEditingController();

  @override
  void dispose() {
    _phraseController.dispose();
    super.dispose();
  }

  void _registerConversation() async {
    final phrase = _phraseController.text.trim();
    if (phrase.isEmpty) return;

    try {
      var response = await ApiOperationWrapper.execute(
        operation: () async {
          return await ref
              .read(aiRegistrationNotifierProvider.notifier)
              .registerAiConversation(phrase);
        },
        context: context,
        successMessage: 'フレーズからAI生成が完了しました。',
      );

      if (mounted) {
        ref.read(conversationsNotifierProvider.notifier).refresh();
        Navigator.of(context).pop(response);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラーが発生しました: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        ref.read(aiRegistrationNotifierProvider.notifier).reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final registrationStatus = ref.watch(aiRegistrationNotifierProvider);
    final isLoading = registrationStatus == AiRegistrationStatus.loading;

    return AlertDialog(
      title: const Text('フレーズからAI生成'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            style: GoogleFonts.rubik(
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            controller: _phraseController,
            decoration: const InputDecoration(
              hintText: '英語でフレーズを入力してください。',
            ),
            maxLines: null, // 複数行入力を可能にする
            minLines: 3, // 初期表示の行数
            keyboardType: TextInputType.multiline, // 複数行入力用のキーボードタイプ
            enabled: !isLoading, // ローディング中は入力を無効化
          ),
          const SizedBox(height: 16),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(null),
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: isLoading ? null : _registerConversation,
          child: const Text('生成'),
        ),
      ],
    );
  }
}

// ダイアログを表示するためのヘルパー関数
Future<String?> showAiGenerateDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return const AiGenerateDialog();
    },
  );
}
