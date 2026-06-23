import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AttendanceCalendarCard extends StatelessWidget {
  final List<Map<String, dynamic>> calendarDays;
  final int offset;
  final int daysInMonth;
  final String formattedMonth;
  final VoidCallback onChangeMonth;

  const AttendanceCalendarCard({
    super.key,
    required this.calendarDays,
    required this.offset,
    required this.daysInMonth,
    required this.formattedMonth,
    required this.onChangeMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedMonth,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: onChangeMonth,
                  child: const Text(
                    'Change Month',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _WeekdayLabel(label: 'S'),
                _WeekdayLabel(label: 'M'),
                _WeekdayLabel(label: 'T'),
                _WeekdayLabel(label: 'W'),
                _WeekdayLabel(label: 'T'),
                _WeekdayLabel(label: 'F'),
                _WeekdayLabel(label: 'S'),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: offset + daysInMonth,
              itemBuilder: (context, index) {
                if (index < offset) {
                  return const SizedBox();
                }
                final dayIndex = index - offset;
                final dayData = calendarDays[dayIndex];
                return _buildCalendarDay(
                  day: dayData['day'] as String,
                  status: dayData['status'] as String,
                );
              },
            ),
            const SizedBox(height: 20),
            const Divider(color: Color(0xFFE5E7EB)),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(
                  color: const Color(0xFF10B981),
                  label: 'Present',
                ),
                const SizedBox(width: 16),
                _buildLegendItem(
                  color: const Color(0xFFEF4444),
                  label: 'Absent',
                ),
                const SizedBox(width: 16),
                _buildLegendItem(
                  color: const Color(0xFFCBD5E1),
                  label: 'Holiday',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarDay({required String day, required String status}) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'present':
        bgColor = const Color(0xFF10B981);
        textColor = Colors.white;
        break;
      case 'absent':
        bgColor = const Color(0xFFEF4444);
        textColor = Colors.white;
        break;
      case 'holiday':
      default:
        bgColor = const Color(0xFFE2E8F0);
        textColor = const Color(0xFF64748B);
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        day,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String label;
  const _WeekdayLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
