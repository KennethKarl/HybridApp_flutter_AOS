import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/widgets/main/symptom_search.dart';

void main() {
  group('SymptomSearch', () {
    testWidgets('displays search placeholder text', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: SymptomSearch()),
      ));

      expect(find.text('증상을 검색해보세요'), findsOneWidget);
    });

    testWidgets('displays search and mic icons', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: SymptomSearch()),
      ));

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.mic_outlined), findsOneWidget);
    });
  });
}
