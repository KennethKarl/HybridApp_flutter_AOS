import 'package:flutter/material.dart';

class BannerItem {
  final String title;
  final String subtitle;
  final String linkUrl;
  final Color bgColor;

  const BannerItem({
    required this.title,
    this.subtitle = '',
    this.linkUrl = '',
    this.bgColor = const Color(0xFFE8F5E9),
  });
}
