import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';

class AttendanceSummaryCard extends StatelessWidget {
  final int present;
  final int absent;
  final int total;
  final int percentage;

  const AttendanceSummaryCard({
    super.key,
    required this.present,
    required this.absent,
    required this.total,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 23, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.17),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem(
                value: present.toDouble(),
                label: 'Present',
                valueColor: const Color(0xFF00B86B),
                bgColor: const Color(0xFFD8FBE7),
              ),
              _buildSummaryItem(
                value: absent.toDouble(),
                label: 'Absent',
                valueColor: const Color(0xFFE60012),
                bgColor: const Color(0xFFFFDCDD),
              ),
              _buildSummaryItem(
                value: total.toDouble(),
                label: 'Total',
                valueColor: const Color(0xFF4B5563),
                bgColor: const Color(0xFFF0F1F4),
              ),
            ],
          ),
          const SizedBox(height: 26),
          AppAnimatedLinearProgress(
            value: total > 0 ? present / total : 0,
            height: 14,
            color: const Color(0xFF05C76B),
            backgroundColor: const Color(0xFFF0F1F4),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required double value,
    required String label,
    required Color valueColor,
    required Color bgColor,
  }) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: AppAnimatedNumber(
            value: value,
            style: TextStyle(
              color: valueColor,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 9),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4B5563),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
