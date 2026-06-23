import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../controllers/notification_controller.dart';

class NotificationFilterBar extends StatelessWidget {
  const NotificationFilterBar({
    required this.selectedFilter,
    required this.onSelected,
    super.key,
  });

  final NotificationFilter selectedFilter;
  final ValueChanged<NotificationFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: NotificationFilter.values.map((filter) {
          final isSelected = filter == selectedFilter;
          return Expanded(
            child: InkWell(
              onTap: () => onSelected(filter),
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  filter.label,
                  maxLines: 1,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF111827),
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
