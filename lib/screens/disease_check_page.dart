import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DiseaseCheckPage extends StatelessWidget {
  const DiseaseCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('건강체크', style: TextStyle(color: AppColors.textMain)),
    );
  }
}
