import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/models/menu_item.dart';

void main() {
  group('AppMenuItem', () {
    test('creates instance with required fields and defaults', () {
      const item = AppMenuItem(
        icon: '🏥',
        iconBg: Color(0xFFE8F5E9),
        title: 'Test Title',
      );

      expect(item.icon, '🏥');
      expect(item.title, 'Test Title');
      expect(item.subtitle, '');
      expect(item.isNew, false);
      expect(item.route, '');
    });

    test('creates instance with all fields', () {
      const item = AppMenuItem(
        icon: '🤖',
        iconBg: Color(0xFFE3F2FD),
        title: 'AI Report',
        subtitle: 'AI-powered',
        isNew: true,
        route: '/ai-report',
      );

      expect(item.isNew, true);
      expect(item.subtitle, 'AI-powered');
      expect(item.route, '/ai-report');
    });
  });
}
