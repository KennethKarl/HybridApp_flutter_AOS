import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../providers/tab_provider.dart';
import '../widgets/common/detail_modal.dart';
import '../models/menu_item.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildProfileCard(),
          const SizedBox(height: 20),
          ...MockData.menuGroups.entries.map(
            (entry) => _buildMenuGroup(context, ref, entry.key, entry.value),
          ),
          SizedBox(height: AppDimens.tabBarHeight + 20),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    final profile = MockData.userProfile;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(AppDimens.cardPadding),
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
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Center(
              child: Text('👤', style: TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: AppFonts.bold,
                  color: AppColors.textMain,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                profile.company,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSub,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: AppColors.textGray),
        ],
      ),
    );
  }

  Widget _buildMenuGroup(
    BuildContext context,
    WidgetRef ref,
    String groupName,
    List<AppMenuItem> items,
  ) {
    const tabMap = {
      '걸음수': 0,
      '건강검진': 1,
      '건강증진': 2,
      '건강체크': 3,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            groupName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: AppFonts.bold,
              color: AppColors.textGray,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
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
          child: Column(
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: item.iconBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          item.icon,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: AppFonts.medium,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.textGray,
                      size: 20,
                    ),
                    onTap: () {
                      final tabIdx = tabMap[item.title];
                      if (tabIdx != null) {
                        ref.read(tabIndexProvider.notifier).state = tabIdx;
                      } else {
                        DetailModal.show(context, item);
                      }
                    },
                  ),
                  if (i < items.length - 1)
                    const Divider(
                      height: 1,
                      indent: 64,
                      color: AppColors.divider,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
