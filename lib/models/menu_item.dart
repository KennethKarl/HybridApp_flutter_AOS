import 'package:flutter/material.dart';

class AppMenuItem {
  final String icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final bool isNew;
  final String route;

  const AppMenuItem({
    required this.icon,
    required this.iconBg,
    required this.title,
    this.subtitle = '',
    this.isNew = false,
    this.route = '',
  });
}
