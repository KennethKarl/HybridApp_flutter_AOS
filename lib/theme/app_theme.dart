import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF0AC262);
  static const primaryDark = Color(0xFF08A854);
  static const background = Color(0xFFF7F7FB);
  static const white = Color(0xFFFFFFFF);
  static const textMain = Color(0xFF1A1A1A);
  static const textSub = Color(0xFF666666);
  static const textGray = Color(0xFF999999);
  static const orange = Color(0xFFFF6B35);
  static const cardShadow = Color(0x0F000000);
  static const divider = Color(0xFFEEEEEE);
}

class AppDimens {
  static const headerHeight = 48.0;
  static const tabBarHeight = 90.0;
  static const containerWidth = 390.0;
  static const badgeSize = 6.0;
  static const cardRadius = 16.0;
  static const cardPadding = 20.0;
  static const tabBarRadius = 30.0;
  static const iconBgSize = 40.0;
  static const iconBgRadius = 12.0;
}

class AppFonts {
  static const tabLabelSize = 10.0;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
}

class AppTheme {
  static ThemeData get light => ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          toolbarHeight: AppDimens.headerHeight,
        ),
        fontFamily: 'Pretendard',
      );
}
