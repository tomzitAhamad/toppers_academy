import 'package:flutter/foundation.dart';

import '../../domain/entities/student_notification.dart';

enum NotificationFilter { all, courses, tests, payment, system }

extension NotificationFilterX on NotificationFilter {
  String get label => switch (this) {
    NotificationFilter.all => 'All',
    NotificationFilter.courses => 'Courses',
    NotificationFilter.tests => 'Tests',
    NotificationFilter.payment => 'Payment',
    NotificationFilter.system => 'System',
  };

  NotificationCategory? get category => switch (this) {
    NotificationFilter.all => null,
    NotificationFilter.courses => NotificationCategory.courses,
    NotificationFilter.tests => NotificationCategory.tests,
    NotificationFilter.payment => NotificationCategory.payment,
    NotificationFilter.system => NotificationCategory.system,
  };
}

class NotificationController extends ChangeNotifier {
  NotificationController()
    : _notifications = [
        const StudentNotification(
          id: 'lesson-available',
          title: 'New Lesson Available',
          message:
              'Writing Task 2 - Opinion Essays is\nnow available in your course',
          timeAgo: '2 hours ago',
          category: NotificationCategory.courses,
          kind: NotificationKind.lesson,
          isUnread: true,
        ),
        const StudentNotification(
          id: 'mock-test-reminder',
          title: 'Mock Test Reminder',
          message: 'Your next mock test is scheduled\nfor tomorrow at 10:00 AM',
          timeAgo: '5 hours ago',
          category: NotificationCategory.tests,
          kind: NotificationKind.test,
          isUnread: true,
        ),
        const StudentNotification(
          id: 'payment-reminder',
          title: 'Payment Due Reminder',
          message: 'Your 2nd installment of ৳4,000 is\ndue on Apr 1, 2026',
          timeAgo: '1 day ago',
          category: NotificationCategory.payment,
          kind: NotificationKind.payment,
        ),
        const StudentNotification(
          id: 'live-class',
          title: 'Live Class Starting Soon',
          message: 'Speaking Practice Session starts\nin 30 minutes',
          timeAgo: '1 day ago',
          category: NotificationCategory.courses,
          kind: NotificationKind.lesson,
        ),
        const StudentNotification(
          id: 'attendance-alert',
          title: 'Attendance Alert',
          message:
              'You have 3 absences this month.\nPlease maintain 75% attendance',
          timeAgo: '2 days ago',
          category: NotificationCategory.system,
          kind: NotificationKind.attendance,
        ),
        const StudentNotification(
          id: 'mock-test-result',
          title: 'Mock Test Result Available',
          message:
              'Your Mock Test #2 result is\nnow available. You scored 8.0!',
          timeAgo: '3 days ago',
          category: NotificationCategory.tests,
          kind: NotificationKind.test,
        ),
      ];

  final List<StudentNotification> _notifications;
  NotificationFilter _selectedFilter = NotificationFilter.all;

  NotificationFilter get selectedFilter => _selectedFilter;

  int get unreadCount =>
      _notifications.where((notification) => notification.isUnread).length;

  List<StudentNotification> get visibleNotifications {
    final selectedCategory = _selectedFilter.category;
    if (selectedCategory == null) {
      return List.unmodifiable(_notifications);
    }

    return _notifications
        .where((notification) => notification.category == selectedCategory)
        .toList(growable: false);
  }

  void selectFilter(NotificationFilter filter) {
    if (_selectedFilter == filter) return;
    _selectedFilter = filter;
    notifyListeners();
  }

  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere(
      (notification) => notification.id == notificationId,
    );
    if (index == -1 || !_notifications[index].isUnread) return;

    _notifications[index] = _notifications[index].copyWith(isUnread: false);
    notifyListeners();
  }
}
