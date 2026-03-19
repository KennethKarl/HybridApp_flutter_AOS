import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/screens/checkup_page.dart';

void main() {
  Widget buildTestWidget() {
    return const MaterialApp(
      home: Scaffold(body: CheckupPage()),
    );
  }

  group('CheckupPage', () {
    testWidgets('renders banner with title', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('나의 건강검진 결과'), findsOneWidget);
      expect(find.text('검진 결과를 확인하고 건강을 관리하세요'), findsOneWidget);
    });

    testWidgets('renders 5 checkup menu items', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('건강검진 알아보기'), findsOneWidget);
      expect(find.text('AI 검진리포트'), findsOneWidget);
      expect(find.text('검진결과 조회'), findsOneWidget);
      expect(find.text('검진 예약'), findsOneWidget);
      expect(find.text('검진 가이드'), findsOneWidget);
    });
  });
}
