import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/models/menu_item.dart';
import 'package:howcare_app/widgets/common/detail_modal.dart';

void main() {
  group('DetailModal', () {
    testWidgets('shows modal with item title and icon', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => DetailModal.show(
                context,
                const AppMenuItem(
                  icon: '🏥',
                  iconBg: Color(0xFFE8F5E9),
                  title: 'Modal Title',
                  subtitle: 'Modal Subtitle',
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Modal Title'), findsOneWidget);
      expect(find.text('Modal Subtitle'), findsOneWidget);
      expect(find.text('🏥'), findsOneWidget);
      expect(find.text('준비 중입니다'), findsOneWidget);
      expect(find.text('🚧'), findsOneWidget);
    });

    testWidgets('closes modal on close icon tap', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => DetailModal.show(
                context,
                const AppMenuItem(
                  icon: '🏥',
                  iconBg: Color(0xFFE8F5E9),
                  title: 'Close Test',
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Close Test'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Close Test'), findsNothing);
    });

    testWidgets('shows placeholder message', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => DetailModal.show(
                context,
                const AppMenuItem(
                  icon: '💊',
                  iconBg: Color(0xFFFCE4EC),
                  title: 'Placeholder Test',
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('빠른 시일 내에 서비스를 제공하겠습니다.'), findsOneWidget);
    });
  });
}
