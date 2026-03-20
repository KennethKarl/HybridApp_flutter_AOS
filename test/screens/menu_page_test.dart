import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howcare_app/screens/menu_page.dart';
import 'package:howcare_app/providers/tab_provider.dart';

void main() {
  Widget buildTestWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: Scaffold(body: MenuPage()),
      ),
    );
  }

  group('MenuPage', () {
    testWidgets('renders user profile card', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('홍길동'), findsOneWidget);
      expect(find.text('GC헬스케어'), findsOneWidget);
    });

    testWidgets('renders menu group headers', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('건강관리'), findsOneWidget);
      expect(find.text('편의서비스'), findsOneWidget);
      expect(find.text('설정'), findsOneWidget);
    });

    testWidgets('renders 건강관리 items', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('걸음수'), findsOneWidget);
      expect(find.text('건강검진'), findsWidgets);
      expect(find.text('건강증진'), findsWidgets);
      expect(find.text('건강체크'), findsWidgets);
    });

    testWidgets('renders 설정 items', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('내정보'), findsOneWidget);
      expect(find.text('알림설정'), findsOneWidget);
      expect(find.text('이용약관'), findsOneWidget);
      expect(find.text('버전정보'), findsOneWidget);
    });

    testWidgets('tapping 걸음수 changes tab to 0', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Start at tab 4 (menu)
      container.read(tabIndexProvider.notifier).state = 4;

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Scaffold(body: MenuPage()),
          ),
        ),
      );

      await tester.tap(find.text('걸음수'));
      await tester.pump();

      expect(container.read(tabIndexProvider), 0);
    });

    testWidgets('tapping 건강검진 menu changes tab to 1', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(tabIndexProvider.notifier).state = 4;

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Scaffold(body: MenuPage()),
          ),
        ),
      );

      // Find the 건강검진 ListTile specifically in the menu group
      final listTiles = find.byType(ListTile);
      // 건강검진 is the second item in 건강관리 group
      await tester.tap(listTiles.at(1));
      await tester.pump();

      expect(container.read(tabIndexProvider), 1);
    });
  });
}
