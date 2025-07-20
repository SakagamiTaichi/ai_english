import 'package:ai_english/features/practice/pages/quiz_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuizSelectionPage', () {
    testWidgets('should render quiz selection page', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const QuizSelectionPage(),
          ),
        ),
      );

      // Verify that the page title is displayed
      expect(find.text('クイズを選択'), findsOneWidget);
      
      // Verify that the study mode options are displayed
      expect(find.text('新規＆復習'), findsOneWidget);
      expect(find.text('新規のみ'), findsOneWidget);
      expect(find.text('復習のみ'), findsOneWidget);
      
      // Verify that the quiz types section title is displayed
      expect(find.text('クイズの種類'), findsOneWidget);
    });

    testWidgets('should allow study mode selection', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const QuizSelectionPage(),
          ),
        ),
      );

      // Tap on '新規のみ' option
      await tester.tap(find.text('新規のみ'));
      await tester.pump();

      // Check that the radio button is selected
      final radio = tester.widget<Radio<StudyMode>>(
        find.byType(Radio<StudyMode>).at(1),
      );
      expect(radio.value, StudyMode.newOnly);
    });
  });
}