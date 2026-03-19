import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/menu_item.dart';

class DetailModal {
  static void show(BuildContext context, AppMenuItem item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _ModalContent(item: item),
    );
  }
}

class _ModalContent extends StatelessWidget {
  final AppMenuItem item;
  const _ModalContent({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: item.iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(item.icon, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: AppFonts.bold,
                    color: AppColors.textMain,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: AppColors.textGray),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (item.subtitle.isNotEmpty)
            Text(
              item.subtitle,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSub,
                height: 1.5,
              ),
            ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Text('🚧', style: TextStyle(fontSize: 32)),
                SizedBox(height: 8),
                Text(
                  '준비 중입니다',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: AppFonts.medium,
                    color: AppColors.textSub,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '빠른 시일 내에 서비스를 제공하겠습니다.',
                  style: TextStyle(fontSize: 13, color: AppColors.textGray),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
