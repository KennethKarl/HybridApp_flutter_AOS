import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('홈', style: TextStyle(color: AppColors.textMain)),
    );
  }
}
