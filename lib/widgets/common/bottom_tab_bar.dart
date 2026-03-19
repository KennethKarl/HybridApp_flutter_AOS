import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_theme.dart';
import '../../providers/tab_provider.dart';

class BottomTabBar extends ConsumerWidget {
  const BottomTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(tabIndexProvider);

    return Container(
      height: AppDimens.tabBarHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimens.tabBarRadius),
          topRight: Radius.circular(AppDimens.tabBarRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimens.tabBarRadius),
          topRight: Radius.circular(AppDimens.tabBarRadius),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => ref.read(tabIndexProvider.notifier).state = index,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textGray,
          selectedFontSize: AppFonts.tabLabelSize,
          unselectedFontSize: AppFonts.tabLabelSize,
          selectedLabelStyle: const TextStyle(fontWeight: AppFonts.medium),
          unselectedLabelStyle: const TextStyle(fontWeight: AppFonts.regular),
          items: const [
            BottomNavigationBarItem(icon: Text('🏠', style: TextStyle(fontSize: 22)), label: '홈'),
            BottomNavigationBarItem(icon: Text('💚', style: TextStyle(fontSize: 22)), label: '건강검진'),
            BottomNavigationBarItem(icon: Text('📋', style: TextStyle(fontSize: 22)), label: '건강증진'),
            BottomNavigationBarItem(icon: Text('🧩', style: TextStyle(fontSize: 22)), label: '건강체크'),
            BottomNavigationBarItem(icon: Text('💬', style: TextStyle(fontSize: 22)), label: '전체'),
          ],
        ),
      ),
    );
  }
}
