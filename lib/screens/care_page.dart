import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/common/menu_card.dart';
import '../widgets/common/detail_modal.dart';

class CarePage extends StatelessWidget {
  const CarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildBanner(),
          const SizedBox(height: 20),
          MenuCard(
            items: MockData.careItems,
            onItemTap: (item) => DetailModal.show(context, item),
          ),
          SizedBox(height: AppDimens.tabBarHeight + 20),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '건강증진 프로그램',
            style: TextStyle(
              fontSize: 22,
              fontWeight: AppFonts.bold,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '건강한 생활습관을 만들어보세요',
            style: TextStyle(fontSize: 14, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
