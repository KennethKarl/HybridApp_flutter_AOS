import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/data/mock_data.dart';

void main() {
  group('MockData', () {
    test('stepData has 7 weekly steps', () {
      expect(MockData.stepData.weeklySteps.length, 7);
    });

    test('stepData has positive step count', () {
      expect(MockData.stepData.stepCount, greaterThan(0));
    });

    test('banners has 8 items', () {
      expect(MockData.banners.length, 8);
    });

    test('all banners have non-empty title', () {
      for (final banner in MockData.banners) {
        expect(banner.title.isNotEmpty, true);
      }
    });

    test('homeMenuTop has 3 items', () {
      expect(MockData.homeMenuTop.length, 3);
    });

    test('homeMenuBottom has 2 items', () {
      expect(MockData.homeMenuBottom.length, 2);
    });

    test('checkupItems has 5 items', () {
      expect(MockData.checkupItems.length, 5);
    });

    test('careItems has 5 items', () {
      expect(MockData.careItems.length, 5);
    });

    test('diseaseCheckItems has 6 items', () {
      expect(MockData.diseaseCheckItems.length, 6);
    });

    test('quizzes has 3 items', () {
      expect(MockData.quizzes.length, 3);
    });

    test('all quizzes have non-empty question', () {
      for (final quiz in MockData.quizzes) {
        expect(quiz.question.isNotEmpty, true);
      }
    });

    test('userProfile has valid name and company', () {
      expect(MockData.userProfile.name, '홍길동');
      expect(MockData.userProfile.company, 'GC헬스케어');
    });

    test('menuGroups has 3 groups', () {
      expect(MockData.menuGroups.length, 3);
    });

    test('menuGroups contains expected group names', () {
      expect(MockData.menuGroups.containsKey('건강관리'), true);
      expect(MockData.menuGroups.containsKey('편의서비스'), true);
      expect(MockData.menuGroups.containsKey('설정'), true);
    });

    test('건강관리 group has 4 items', () {
      expect(MockData.menuGroups['건강관리']!.length, 4);
    });

    test('편의서비스 group has 3 items', () {
      expect(MockData.menuGroups['편의서비스']!.length, 3);
    });

    test('설정 group has 4 items', () {
      expect(MockData.menuGroups['설정']!.length, 4);
    });
  });
}
