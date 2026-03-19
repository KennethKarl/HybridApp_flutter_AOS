import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howcare_app/app.dart';
import 'package:howcare_app/providers/tab_provider.dart';

void main() {
  Widget buildApp({int initialTab = 0}) {
    return ProviderScope(
      overrides: [
        tabIndexProvider.overrideWith((ref) => initialTab),
      ],
      child: const App(),
    );
  }

  group('AppLayout - Tab Navigation', () {
    testWidgets('renders header with app title', (tester) async {
      await tester.pumpWidget(buildApp());

      expect(find.text('어떠케어'), findsOneWidget);
    });

    testWidgets('renders all 5 tab labels', (tester) async {
      await tester.pumpWidget(buildApp());

      expect(find.text('홈'), findsWidgets);
      expect(find.text('건강검진'), findsWidgets);
      expect(find.text('건강증진'), findsWidgets);
      expect(find.text('건강체크'), findsWidgets);
      expect(find.text('전체'), findsWidgets);
    });

    testWidgets('shows MainPage content on tab 0 (default)', (tester) async {
      await tester.pumpWidget(buildApp());

      // MainPage has StepCounter with '걸음' text
      expect(find.text('걸음'), findsOneWidget);
    });

    testWidgets('switches to CheckupPage on tab 1 tap', (tester) async {
      await tester.pumpWidget(buildApp());

      // Find the 건강검진 tab in the BottomNavigationBar and tap it
      final bottomNav = find.byType(BottomNavigationBar);
      expect(bottomNav, findsOneWidget);

      // Tap the second tab (건강검진)
      await tester.tap(find.text('💚'));
      await tester.pumpAndSettle();

      // CheckupPage has '나의 건강검진 결과' banner title
      expect(find.text('나의 건강검진 결과'), findsOneWidget);
    });

    testWidgets('switches to CarePage on tab 2 tap', (tester) async {
      await tester.pumpWidget(buildApp());

      await tester.tap(find.text('📋'));
      await tester.pumpAndSettle();

      expect(find.text('건강증진 프로그램'), findsOneWidget);
    });

    testWidgets('switches to DiseaseCheckPage on tab 3 tap', (tester) async {
      await tester.pumpWidget(buildApp());

      await tester.tap(find.text('🧩'));
      await tester.pumpAndSettle();

      // DiseaseCheckPage has subtitle text
      expect(find.text('간단한 자가검진으로 건강 상태를 확인해보세요'), findsOneWidget);
    });

    testWidgets('switches to MenuPage on tab 4 tap', (tester) async {
      await tester.pumpWidget(buildApp());

      await tester.tap(find.text('💬'));
      await tester.pumpAndSettle();

      // MenuPage has user profile name
      expect(find.text('홍길동'), findsOneWidget);
      expect(find.text('GC헬스케어'), findsOneWidget);
    });

    testWidgets('renders notification and settings icons', (tester) async {
      await tester.pumpWidget(buildApp());

      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });
  });
}
