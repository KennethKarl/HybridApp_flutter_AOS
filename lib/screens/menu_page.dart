import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('전체', style: TextStyle(color: AppColors.textMain)),
    );
  }
}
