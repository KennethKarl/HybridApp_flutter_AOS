import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/tab_provider.dart';
import 'widgets/common/app_header.dart';
import 'widgets/common/bottom_tab_bar.dart';
import 'screens/main_page.dart';
import 'screens/checkup_page.dart';
import 'screens/care_page.dart';
import 'screens/disease_check_page.dart';
import 'screens/menu_page.dart';

class AppLayout extends ConsumerWidget {
  const AppLayout({super.key});

  static const _pages = <Widget>[
    MainPage(),
    CheckupPage(),
    CarePage(),
    DiseaseCheckPage(),
    MenuPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(tabIndexProvider);

    return Scaffold(
      appBar: const AppHeader(),
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: const BottomTabBar(),
    );
  }
}
