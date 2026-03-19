import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/quiz.dart';

class HealthQuiz extends StatefulWidget {
  final Quiz quiz;
  const HealthQuiz({super.key, required this.quiz});

  @override
  State<HealthQuiz> createState() => _HealthQuizState();
}

class _HealthQuizState extends State<HealthQuiz> {
  bool _isAnswered = false;
  bool? _userAnswer;

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '오늘의 건강퀴즈',
            style: TextStyle(
              fontSize: 14,
              fontWeight: AppFonts.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.quiz.question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: AppFonts.medium,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildButton('O', true)),
              const SizedBox(width: 12),
              Expanded(child: _buildButton('X', false)),
            ],
          ),
          if (_isAnswered) ...[
            const SizedBox(height: 12),
            Text(
              _userAnswer == widget.quiz.answer ? '정답입니다! 🎉' : '오답입니다 😅',
              style: TextStyle(
                fontSize: 14,
                fontWeight: AppFonts.medium,
                color: _userAnswer == widget.quiz.answer
                    ? AppColors.primary
                    : AppColors.orange,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildButton(String label, bool value) {
    final isSelected = _isAnswered && _userAnswer == value;
    final isCorrect = widget.quiz.answer == value;

    Color bgColor;
    Color textColor;
    if (!_isAnswered) {
      bgColor = AppColors.background;
      textColor = AppColors.textMain;
    } else if (isSelected && isCorrect) {
      bgColor = AppColors.primary.withValues(alpha: 0.1);
      textColor = AppColors.primary;
    } else if (isSelected && !isCorrect) {
      bgColor = AppColors.orange.withValues(alpha: 0.1);
      textColor = AppColors.orange;
    } else {
      bgColor = AppColors.background;
      textColor = AppColors.textGray;
    }

    return GestureDetector(
      onTap: _isAnswered
          ? null
          : () => setState(() {
                _isAnswered = true;
                _userAnswer = value;
              }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(
                  color: isCorrect ? AppColors.primary : AppColors.orange,
                  width: 2,
                )
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: AppFonts.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
