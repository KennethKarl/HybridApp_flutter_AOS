import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CarePage extends StatelessWidget {
  const CarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('건강증진', style: TextStyle(color: AppColors.textMain)),
    );
  }
}
