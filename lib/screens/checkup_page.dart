import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/common/menu_card.dart';
import '../widgets/common/detail_modal.dart';

class CheckupPage extends StatelessWidget {
  const CheckupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildBanner(),
          const SizedBox(height: 20),
          MenuCard(
            items: MockData.checkupItems,
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
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '나의 건강검진 결과',
            style: TextStyle(
              fontSize: 22,
              fontWeight: AppFonts.bold,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '검진 결과를 확인하고 건강을 관리하세요',
            style: TextStyle(fontSize: 14, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
