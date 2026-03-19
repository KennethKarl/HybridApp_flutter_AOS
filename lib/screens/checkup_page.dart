import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CheckupPage extends StatelessWidget {
  const CheckupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('건강검진', style: TextStyle(color: AppColors.textMain)),
    );
  }
}
