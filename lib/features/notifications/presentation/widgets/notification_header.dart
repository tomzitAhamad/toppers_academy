import 'package:flutter/material.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({
    required this.unreadCount,
    required this.onBack,
    this.topPadding,
    super.key,
  });

  final int unreadCount;
  final VoidCallback onBack;
  final double? topPadding;

  @override
  Widget build(BuildContext context) {
    final double actualTopPadding = topPadding ?? 29.0;
    return Container(
      height: 120.0 + actualTopPadding,
      padding: EdgeInsets.fromLTRB(18, actualTopPadding, 18, 18),
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 40, height: 40),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 27),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notifications',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  AppAnimatedText(
                    value: '$unreadCount unread notifications',
                    style: const TextStyle(
                      color: Color(0xFFD9D6FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _NotificationBadge(count: unreadCount),
        ],
      ),
    );
  }
}

class _NotificationBadge extends StatelessWidget {
  const _NotificationBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const SizedBox(
          width: 38,
          height: 38,
          child: Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
            size: 27,
          ),
        ),
        if (count > 0)
          Positioned(
            right: -1,
            top: -5,
            child: Container(
              constraints: const BoxConstraints(minWidth: 23, minHeight: 23),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFFF3155),
                shape: BoxShape.circle,
              ),
              child: AppAnimatedText(
                value: '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
