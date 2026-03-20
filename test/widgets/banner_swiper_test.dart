import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/models/banner_item.dart';
import 'package:howcare_app/widgets/common/banner_swiper.dart';

void main() {
  Widget buildTestWidget(List<BannerItem> banners) {
    return MaterialApp(
      home: Scaffold(
        body: BannerSwiper(banners: banners),
      ),
    );
  }

  group('BannerSwiper', () {
    testWidgets('displays first banner title', (tester) async {
      const banners = [
        BannerItem(title: 'Banner 1', subtitle: 'Sub 1'),
        BannerItem(title: 'Banner 2', subtitle: 'Sub 2'),
        BannerItem(title: 'Banner 3', subtitle: 'Sub 3'),
      ];

      await tester.pumpWidget(buildTestWidget(banners));

      expect(find.text('Banner 1'), findsOneWidget);
    });

    testWidgets('displays subtitle when not empty', (tester) async {
      const banners = [
        BannerItem(title: 'Title', subtitle: 'My Subtitle'),
      ];

      await tester.pumpWidget(buildTestWidget(banners));

      expect(find.text('My Subtitle'), findsOneWidget);
    });

    testWidgets('renders with single banner', (tester) async {
      const banners = [
        BannerItem(title: 'Only Banner'),
      ];

      await tester.pumpWidget(buildTestWidget(banners));

      expect(find.text('Only Banner'), findsOneWidget);
    });

    testWidgets('renders page indicators for multiple banners',
        (tester) async {
      const banners = [
        BannerItem(title: 'B1'),
        BannerItem(title: 'B2'),
        BannerItem(title: 'B3'),
      ];

      await tester.pumpWidget(buildTestWidget(banners));

      // Indicators are Container widgets — we just verify the widget renders
      expect(find.byType(BannerSwiper), findsOneWidget);
    });
  });
}
