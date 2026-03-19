import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/models/step_data.dart';
import 'package:howcare_app/widgets/main/step_counter.dart';

void main() {
  Widget buildTestWidget(StepData data) {
    return MaterialApp(
      home: Scaffold(
        body: StepCounter(data: data),
      ),
    );
  }

  group('StepCounter', () {
    testWidgets('displays formatted step count', (tester) async {
      const data = StepData(
        stepCount: 6847,
        leafPoint: 32,
        weeklySteps: [4200, 7800, 5100, 8300, 6200, 3900, 6847],
        currentDayIndex: 3,
      );

      await tester.pumpWidget(buildTestWidget(data));

      expect(find.text('6,847'), findsOneWidget);
      expect(find.text('걸음'), findsOneWidget);
    });

    testWidgets('displays leaf point', (tester) async {
      const data = StepData(
        stepCount: 1000,
        leafPoint: 50,
        weeklySteps: [1000, 1000, 1000, 1000, 1000, 1000, 1000],
        currentDayIndex: 0,
      );

      await tester.pumpWidget(buildTestWidget(data));

      expect(find.text('리프포인트 50'), findsOneWidget);
    });

    testWidgets('displays 7 day labels', (tester) async {
      const data = StepData(
        stepCount: 5000,
        leafPoint: 20,
        weeklySteps: [1000, 2000, 3000, 4000, 5000, 6000, 7000],
        currentDayIndex: 0,
      );

      await tester.pumpWidget(buildTestWidget(data));

      for (final label in ['일', '월', '화', '수', '목', '금', '토']) {
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('formats number below 1000 without comma', (tester) async {
      const data = StepData(
        stepCount: 999,
        leafPoint: 5,
        weeklySteps: [100, 200, 300, 400, 500, 600, 999],
        currentDayIndex: 6,
      );

      await tester.pumpWidget(buildTestWidget(data));

      expect(find.text('999'), findsOneWidget);
    });

    testWidgets('formats number at 1000 boundary with comma', (tester) async {
      const data = StepData(
        stepCount: 1000,
        leafPoint: 10,
        weeklySteps: [1000, 0, 0, 0, 0, 0, 0],
        currentDayIndex: 0,
      );

      await tester.pumpWidget(buildTestWidget(data));

      expect(find.text('1,000'), findsOneWidget);
    });

    testWidgets('handles zero step count', (tester) async {
      const data = StepData(
        stepCount: 0,
        leafPoint: 0,
        weeklySteps: [0, 0, 0, 0, 0, 0, 0],
        currentDayIndex: 0,
      );

      await tester.pumpWidget(buildTestWidget(data));

      expect(find.text('0'), findsOneWidget);
      expect(find.text('리프포인트 0'), findsOneWidget);
    });
  });
}
