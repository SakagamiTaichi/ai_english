import 'package:ai_english/features/practice/models/recall_test_request_model.dart';
import 'package:ai_english/features/practice/providers/recall_test_result_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecallTestSummaryPage extends ConsumerStatefulWidget {
  final RecallTestRequestModel requestModels;

  const RecallTestSummaryPage({super.key, required this.requestModels});

  @override
  ConsumerState<RecallTestSummaryPage> createState() =>
      _RecallTestSummaryPageState();
}

class _RecallTestSummaryPageState extends ConsumerState<RecallTestSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final data =
        ref.watch(recallTestResultProviderProvider(widget.requestModels));
    return SizedBox(height: 10);
  }
}
