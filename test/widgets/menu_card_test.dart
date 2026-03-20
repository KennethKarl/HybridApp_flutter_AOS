import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/models/menu_item.dart';
import 'package:howcare_app/widgets/common/menu_card.dart';

void main() {
  Widget buildTestWidget({
    required List<AppMenuItem> items,
    void Function(AppMenuItem)? onItemTap,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: MenuCard(items: items, onItemTap: onItemTap),
        ),
      ),
    );
  }

  group('MenuCard', () {
    testWidgets('displays all item titles', (tester) async {
      const items = [
        AppMenuItem(icon: '🏥', iconBg: Color(0xFFE8F5E9), title: 'Item 1'),
        AppMenuItem(icon: '🤖', iconBg: Color(0xFFE3F2FD), title: 'Item 2'),
        AppMenuItem(icon: '💡', iconBg: Color(0xFFFFF3E0), title: 'Item 3'),
      ];

      await tester.pumpWidget(buildTestWidget(items: items));

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('displays subtitle when provided', (tester) async {
      const items = [
        AppMenuItem(
          icon: '🏥',
          iconBg: Color(0xFFE8F5E9),
          title: 'Title',
          subtitle: 'Subtitle text',
        ),
      ];

      await tester.pumpWidget(buildTestWidget(items: items));

      expect(find.text('Subtitle text'), findsOneWidget);
    });

    testWidgets('displays NEW badge when isNew is true', (tester) async {
      const items = [
        AppMenuItem(
          icon: '🤖',
          iconBg: Color(0xFFE3F2FD),
          title: 'New Feature',
          isNew: true,
        ),
      ];

      await tester.pumpWidget(buildTestWidget(items: items));

      expect(find.text('NEW'), findsOneWidget);
    });

    testWidgets('does not display NEW badge when isNew is false',
        (tester) async {
      const items = [
        AppMenuItem(
          icon: '🏥',
          iconBg: Color(0xFFE8F5E9),
          title: 'Regular Item',
        ),
      ];

      await tester.pumpWidget(buildTestWidget(items: items));

      expect(find.text('NEW'), findsNothing);
    });

    testWidgets('triggers onItemTap callback', (tester) async {
      AppMenuItem? tappedItem;
      const items = [
        AppMenuItem(
          icon: '🏥',
          iconBg: Color(0xFFE8F5E9),
          title: 'Tappable',
        ),
      ];

      await tester.pumpWidget(buildTestWidget(
        items: items,
        onItemTap: (item) => tappedItem = item,
      ));

      await tester.tap(find.text('Tappable'));
      await tester.pump();

      expect(tappedItem, isNotNull);
      expect(tappedItem!.title, 'Tappable');
    });

    testWidgets('displays chevron icon for each item', (tester) async {
      const items = [
        AppMenuItem(icon: '🏥', iconBg: Color(0xFFE8F5E9), title: 'Item'),
      ];

      await tester.pumpWidget(buildTestWidget(items: items));

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('displays emoji icon', (tester) async {
      const items = [
        AppMenuItem(icon: '🏥', iconBg: Color(0xFFE8F5E9), title: 'Hospital'),
      ];

      await tester.pumpWidget(buildTestWidget(items: items));

      expect(find.text('🏥'), findsOneWidget);
    });
  });
}
