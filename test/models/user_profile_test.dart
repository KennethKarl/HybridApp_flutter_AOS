import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/models/user_profile.dart';

void main() {
  group('UserProfile', () {
    test('creates instance with required fields and defaults', () {
      const profile = UserProfile(name: 'John', company: 'TestCo');

      expect(profile.name, 'John');
      expect(profile.company, 'TestCo');
      expect(profile.avatarUrl, '');
    });

    test('creates instance with avatarUrl', () {
      const profile = UserProfile(
        name: 'Jane',
        company: 'Corp',
        avatarUrl: 'https://example.com/avatar.png',
      );

      expect(profile.avatarUrl, 'https://example.com/avatar.png');
    });
  });
}
