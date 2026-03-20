import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/models/banner_item.dart';

void main() {
  group('BannerItem', () {
    test('creates instance with required fields and defaults', () {
      const item = BannerItem(title: 'Banner Title');

      expect(item.title, 'Banner Title');
      expect(item.subtitle, '');
      expect(item.linkUrl, '');
      expect(item.bgColor, const Color(0xFFE8F5E9));
    });

    test('creates instance with all fields', () {
      const item = BannerItem(
        title: 'Test',
        subtitle: 'Sub',
        linkUrl: '/test',
        bgColor: Color(0xFFFFFFFF),
      );

      expect(item.subtitle, 'Sub');
      expect(item.linkUrl, '/test');
    });
  });
}
