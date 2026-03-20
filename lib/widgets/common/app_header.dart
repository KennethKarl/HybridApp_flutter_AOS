import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.headerHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      toolbarHeight: AppDimens.headerHeight,
      title: const Text(
        '어떠케어',
        style: TextStyle(
          fontSize: 20,
          fontWeight: AppFonts.extraBold,
          color: AppColors.white,
        ),
      ),
      actions: [
        _buildIconButton(Icons.notifications_outlined),
        _buildIconButton(Icons.settings_outlined),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.white, size: 18),
      ),
    );
  }
}
