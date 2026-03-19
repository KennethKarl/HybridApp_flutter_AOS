import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howcare_app/theme/app_theme.dart';

void main() {
  group('AppColors', () {
    test('primary color is correct', () {
      expect(AppColors.primary, const Color(0xFF0AC262));
    });

    test('all color constants are defined', () {
      expect(AppColors.primaryDark, isNotNull);
      expect(AppColors.background, isNotNull);
      expect(AppColors.white, isNotNull);
      expect(AppColors.textMain, isNotNull);
      expect(AppColors.textSub, isNotNull);
      expect(AppColors.textGray, isNotNull);
      expect(AppColors.orange, isNotNull);
      expect(AppColors.cardShadow, isNotNull);
      expect(AppColors.divider, isNotNull);
    });
  });

  group('AppDimens', () {
    test('header height is 48', () {
      expect(AppDimens.headerHeight, 48.0);
    });

    test('tab bar height is 90', () {
      expect(AppDimens.tabBarHeight, 90.0);
    });

    test('all dimension constants are defined', () {
      expect(AppDimens.containerWidth, 390.0);
      expect(AppDimens.badgeSize, 6.0);
      expect(AppDimens.cardRadius, 16.0);
      expect(AppDimens.cardPadding, 20.0);
      expect(AppDimens.tabBarRadius, 30.0);
      expect(AppDimens.iconBgSize, 40.0);
      expect(AppDimens.iconBgRadius, 12.0);
    });
  });

  group('AppFonts', () {
    test('font weights are correctly defined', () {
      expect(AppFonts.regular, FontWeight.w400);
      expect(AppFonts.medium, FontWeight.w500);
      expect(AppFonts.bold, FontWeight.w700);
      expect(AppFonts.extraBold, FontWeight.w800);
    });

    test('tab label size is 10', () {
      expect(AppFonts.tabLabelSize, 10.0);
    });
  });

  group('AppTheme', () {
    test('light theme uses correct primary color', () {
      final theme = AppTheme.light;
      expect(theme.primaryColor, AppColors.primary);
    });

    test('light theme uses correct scaffold background', () {
      final theme = AppTheme.light;
      expect(theme.scaffoldBackgroundColor, AppColors.background);
    });

    test('light theme appBar uses primary color', () {
      final theme = AppTheme.light;
      expect(theme.appBarTheme.backgroundColor, AppColors.primary);
      expect(theme.appBarTheme.elevation, 0);
      expect(theme.appBarTheme.toolbarHeight, AppDimens.headerHeight);
    });
  });
}
