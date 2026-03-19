import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/screens/disease_check_page.dart';

void main() {
  Widget buildTestWidget() {
    return const MaterialApp(
      home: Scaffold(body: DiseaseCheckPage()),
    );
  }

  group('DiseaseCheckPage', () {
    testWidgets('renders title and subtitle', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('건강체크'), findsOneWidget);
      expect(find.text('간단한 자가검진으로 건강 상태를 확인해보세요'), findsOneWidget);
    });

    testWidgets('renders 6 disease check menu items', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('우울증'), findsOneWidget);
      expect(find.text('공황장애'), findsOneWidget);
      expect(find.text('알코올'), findsOneWidget);
      expect(find.text('흡연'), findsOneWidget);
      expect(find.text('스트레스'), findsOneWidget);
      expect(find.text('수면장애'), findsOneWidget);
    });
  });
}
