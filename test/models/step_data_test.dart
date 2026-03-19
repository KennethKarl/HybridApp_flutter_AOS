import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/models/step_data.dart';

void main() {
  group('StepData', () {
    test('creates instance with required fields', () {
      const data = StepData(
        stepCount: 6847,
        leafPoint: 32,
        weeklySteps: [4200, 7800, 5100, 8300, 6200, 3900, 6847],
        currentDayIndex: 3,
      );

      expect(data.stepCount, 6847);
      expect(data.leafPoint, 32);
      expect(data.weeklySteps.length, 7);
      expect(data.currentDayIndex, 3);
    });

    test('supports zero step count', () {
      const data = StepData(
        stepCount: 0,
        leafPoint: 0,
        weeklySteps: [0, 0, 0, 0, 0, 0, 0],
        currentDayIndex: 0,
      );

      expect(data.stepCount, 0);
      expect(data.leafPoint, 0);
    });

    test('supports large step count', () {
      const data = StepData(
        stepCount: 99999,
        leafPoint: 500,
        weeklySteps: [10000, 20000, 15000, 18000, 12000, 9000, 99999],
        currentDayIndex: 6,
      );

      expect(data.stepCount, 99999);
    });
  });
}
