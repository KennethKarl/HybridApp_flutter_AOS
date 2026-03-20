import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/models/quiz.dart';
import 'package:howcare_app/widgets/main/health_quiz.dart';

void main() {
  Widget buildTestWidget(Quiz quiz) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: HealthQuiz(quiz: quiz),
        ),
      ),
    );
  }

  group('HealthQuiz', () {
    testWidgets('displays quiz question and O/X buttons', (tester) async {
      const quiz = Quiz(question: '테스트 질문입니다?', answer: true);

      await tester.pumpWidget(buildTestWidget(quiz));

      expect(find.text('오늘의 건강퀴즈'), findsOneWidget);
      expect(find.text('테스트 질문입니다?'), findsOneWidget);
      expect(find.text('O'), findsOneWidget);
      expect(find.text('X'), findsOneWidget);
    });

    testWidgets('shows correct answer feedback when user answers correctly',
        (tester) async {
      const quiz = Quiz(question: '물은 좋다?', answer: true);

      await tester.pumpWidget(buildTestWidget(quiz));

      // Tap 'O' (correct answer)
      await tester.tap(find.text('O'));
      await tester.pump();

      expect(find.text('정답입니다! 🎉'), findsOneWidget);
    });

    testWidgets('shows wrong answer feedback when user answers incorrectly',
        (tester) async {
      const quiz = Quiz(question: '커피 5잔 OK?', answer: false);

      await tester.pumpWidget(buildTestWidget(quiz));

      // Tap 'O' (wrong answer, correct is false)
      await tester.tap(find.text('O'));
      await tester.pump();

      expect(find.text('오답입니다 😅'), findsOneWidget);
    });

    testWidgets('prevents double answering', (tester) async {
      const quiz = Quiz(question: 'Test?', answer: true);

      await tester.pumpWidget(buildTestWidget(quiz));

      // First tap
      await tester.tap(find.text('O'));
      await tester.pump();

      expect(find.text('정답입니다! 🎉'), findsOneWidget);

      // Second tap on 'X' should not change the result
      await tester.tap(find.text('X'));
      await tester.pump();

      // Still shows correct feedback (not changed)
      expect(find.text('정답입니다! 🎉'), findsOneWidget);
    });

    testWidgets('X button works for false answer quiz', (tester) async {
      const quiz = Quiz(question: 'False quiz?', answer: false);

      await tester.pumpWidget(buildTestWidget(quiz));

      await tester.tap(find.text('X'));
      await tester.pump();

      expect(find.text('정답입니다! 🎉'), findsOneWidget);
    });
  });
}
