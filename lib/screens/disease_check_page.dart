import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/common/menu_card.dart';
import '../widgets/common/detail_modal.dart';

class DiseaseCheckPage extends StatelessWidget {
  const DiseaseCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '건강체크',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: AppFonts.bold,
                    color: AppColors.textMain,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '간단한 자가검진으로 건강 상태를 확인해보세요',
                  style: TextStyle(fontSize: 14, color: AppColors.textSub),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          MenuCard(
            items: MockData.diseaseCheckItems,
            onItemTap: (item) => DetailModal.show(context, item),
          ),
          SizedBox(height: AppDimens.tabBarHeight + 20),
        ],
      ),
    );
  }
}
