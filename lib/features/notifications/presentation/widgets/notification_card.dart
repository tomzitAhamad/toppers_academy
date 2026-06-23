import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/student_notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.notification,
    required this.onTap,
    super.key,
  });

  final StudentNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = _NotificationVisualStyle.from(notification.kind);
    final leftPadding = notification.isUnread ? 19.0 : 15.0;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          constraints: const BoxConstraints(minHeight: 128),
          padding: EdgeInsets.fromLTRB(leftPadding, 16, 15, 13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: notification.isUnread
                ? const Border(
                    left: BorderSide(color: AppColors.primary, width: 4),
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF101828).withValues(alpha: 0.12),
                blurRadius: 2,
                offset: const Offset(0, 1.5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: style.backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(style.icon, color: style.iconColor, size: 21),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 1.18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      notification.message,
                      style: const TextStyle(
                        color: Color(0xFF536075),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.42,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification.timeAgo,
                      style: const TextStyle(
                        color: Color(0xFF98A2B3),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (notification.isUnread)
                const Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: Icon(Icons.circle, color: AppColors.primary, size: 8),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationVisualStyle {
  const _NotificationVisualStyle({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  factory _NotificationVisualStyle.from(NotificationKind kind) {
    return switch (kind) {
      NotificationKind.lesson => const _NotificationVisualStyle(
        icon: Icons.menu_book_outlined,
        iconColor: Color(0xFF146BFF),
        backgroundColor: Color(0xFFDDEBFF),
      ),
      NotificationKind.test => const _NotificationVisualStyle(
        icon: Icons.description_outlined,
        iconColor: Color(0xFFA400FF),
        backgroundColor: Color(0xFFF2E2FF),
      ),
      NotificationKind.payment => const _NotificationVisualStyle(
        icon: Icons.credit_card,
        iconColor: Color(0xFFFF7900),
        backgroundColor: Color(0xFFFFF0C5),
      ),
      NotificationKind.attendance => const _NotificationVisualStyle(
        icon: Icons.error_outline,
        iconColor: Color(0xFFFF2438),
        backgroundColor: Color(0xFFFFDEDF),
      ),
    };
  }
}
