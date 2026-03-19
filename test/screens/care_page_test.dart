import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/screens/care_page.dart';

void main() {
  Widget buildTestWidget() {
    return const MaterialApp(
      home: Scaffold(body: CarePage()),
    );
  }

  group('CarePage', () {
    testWidgets('renders banner with title', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('건강증진 프로그램'), findsOneWidget);
      expect(find.text('건강한 생활습관을 만들어보세요'), findsOneWidget);
    });

    testWidgets('renders 5 care menu items', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('운동 프로그램'), findsOneWidget);
      expect(find.text('영양 관리'), findsOneWidget);
      expect(find.text('스트레스 관리'), findsOneWidget);
      expect(find.text('금연 프로그램'), findsOneWidget);
      expect(find.text('체중 관리'), findsOneWidget);
    });
  });
}
