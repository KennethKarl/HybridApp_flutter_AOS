import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/models/quiz.dart';

void main() {
  group('Quiz', () {
    test('creates instance with defaults', () {
      const quiz = Quiz(question: 'Test?', answer: true);

      expect(quiz.question, 'Test?');
      expect(quiz.answer, true);
      expect(quiz.isAnswered, false);
      expect(quiz.userAnswer, isNull);
    });

    test('copyWith updates isAnswered and userAnswer', () {
      const quiz = Quiz(question: 'Test?', answer: true);
      final answered = quiz.copyWith(isAnswered: true, userAnswer: true);

      expect(answered.isAnswered, true);
      expect(answered.userAnswer, true);
      expect(answered.question, 'Test?');
      expect(answered.answer, true);
    });

    test('copyWith preserves original values when not specified', () {
      const quiz = Quiz(
        question: 'Test?',
        answer: false,
        isAnswered: true,
        userAnswer: true,
      );
      final copy = quiz.copyWith();

      expect(copy.isAnswered, true);
      expect(copy.userAnswer, true);
    });

    test('copyWith only updates specified fields', () {
      const quiz = Quiz(question: 'Q?', answer: true);
      final copy = quiz.copyWith(isAnswered: true);

      expect(copy.isAnswered, true);
      expect(copy.userAnswer, isNull);
    });
  });
}
