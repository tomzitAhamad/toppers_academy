import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';
import 'progress_chart.dart';

class HomeBandScoreCard extends StatelessWidget {
  const HomeBandScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Band Score Progress',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Icon(Icons.trending_up, color: Color(0xFF22C55E)),
            ],
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              const AppAnimatedNumber(
                value: 7.5,
                decimalPlaces: 1,
                style: TextStyle(
                  color: Color(0xFF4F46FF),
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 9),
              const Text(
                'Current Band',
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9FBE6),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  '+1.0 from start',
                  style: TextStyle(
                    color: Color(0xFF079344),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const ProgressChart(),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFFE5E7EB)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _scoreItem(7.5, 'Listening'),
              _scoreItem(8, 'Reading'),
              _scoreItem(7, 'Writing'),
              _scoreItem(7.5, 'Speaking'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _scoreItem(double score, String title) {
    return Column(
      children: [
        AppAnimatedNumber(
          value: score,
          decimalPlaces: score % 1 == 0 ? 0 : 1,
          style: const TextStyle(
            color: Color(0xFF4F46FF),
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Color(0xFF4B5563), fontSize: 12),
        ),
      ],
    );
  }
}
