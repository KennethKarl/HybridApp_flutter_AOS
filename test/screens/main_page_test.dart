import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howcare_app/screens/main_page.dart';

void main() {
  Widget buildTestWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: Scaffold(body: MainPage()),
      ),
    );
  }

  group('MainPage', () {
    testWidgets('renders StepCounter section', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('걸음'), findsOneWidget);
    });

    testWidgets('renders BannerSwiper section', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      // First banner title should be visible
      expect(find.textContaining('검진결과'), findsWidgets);
    });

    testWidgets('renders HealthQuiz section', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('오늘의 건강퀴즈'), findsOneWidget);
    });

    testWidgets('renders SymptomSearch section', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('증상을 검색해보세요'), findsOneWidget);
    });

    testWidgets('renders home menu items', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('건강검진 알아보기'), findsOneWidget);
    });
  });
}
