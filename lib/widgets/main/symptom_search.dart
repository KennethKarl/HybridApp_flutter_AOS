import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SymptomSearch extends StatelessWidget {
  const SymptomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: AppColors.textGray, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '증상을 검색해보세요',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textGray,
              ),
            ),
          ),
          Icon(Icons.mic_outlined, color: AppColors.textGray, size: 20),
        ],
      ),
    );
  }
}
