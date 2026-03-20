import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/step_data.dart';

class StepCounter extends StatelessWidget {
  final StepData data;
  const StepCounter({super.key, required this.data});

  static const _dayLabels = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      child: Column(
        children: [
          Text(
            _formatNumber(data.stepCount),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: AppFonts.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '걸음',
            style: TextStyle(fontSize: 14, color: AppColors.white),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🌿', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 4),
                Text(
                  '리프포인트 ${data.leafPoint}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.white,
                    fontWeight: AppFonts.medium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildWeeklyChart(),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    final maxSteps = data.weeklySteps.reduce((a, b) => a > b ? a : b);
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (i) {
          final ratio = maxSteps > 0 ? data.weeklySteps[i] / maxSteps : 0.0;
          final isToday = i == data.currentDayIndex;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      width: 20,
                      height: 50 * ratio,
                      decoration: BoxDecoration(
                        color: isToday
                            ? AppColors.white
                            : Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _dayLabels[i],
                    style: TextStyle(
                      fontSize: 11,
                      color: isToday
                          ? AppColors.white
                          : Colors.white.withValues(alpha: 0.6),
                      fontWeight: isToday ? AppFonts.bold : AppFonts.regular,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) {
      final s = n.toString();
      return '${s.substring(0, s.length - 3)},${s.substring(s.length - 3)}';
    }
    return n.toString();
  }
}
