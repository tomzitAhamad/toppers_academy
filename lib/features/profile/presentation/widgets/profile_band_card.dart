import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';

class ProfileBandCard extends StatelessWidget {
  final String title;
  final String score;
  final Color iconColor;
  final Color bgColor;

  const ProfileBandCard({
    super.key,
    required this.title,
    required this.score,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(
              Icons.emoji_events_outlined,
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(height: 8),
          AppAnimatedNumber(
            value: double.tryParse(score) ?? 0,
            decimalPlaces: score.contains('.') ? 1 : 0,
            style: TextStyle(
              color: iconColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
