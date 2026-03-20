import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/main/step_counter.dart';
import '../widgets/common/banner_swiper.dart';
import '../widgets/common/menu_card.dart';
import '../widgets/main/health_quiz.dart';
import '../widgets/main/symptom_search.dart';
import '../widgets/common/detail_modal.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StepCounter(data: MockData.stepData),
          const SizedBox(height: 20),
          BannerSwiper(banners: MockData.banners),
          const SizedBox(height: 20),
          MenuCard(
            items: MockData.homeMenuTop,
            onItemTap: (item) => DetailModal.show(context, item),
          ),
          const SizedBox(height: 16),
          MenuCard(
            items: MockData.homeMenuBottom,
            onItemTap: (item) => DetailModal.show(context, item),
          ),
          const SizedBox(height: 16),
          HealthQuiz(quiz: MockData.quizzes[0]),
          const SizedBox(height: 16),
          const SymptomSearch(),
          SizedBox(height: AppDimens.tabBarHeight + 20),
        ],
      ),
    );
  }
}
