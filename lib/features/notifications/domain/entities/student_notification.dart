enum NotificationCategory { courses, tests, payment, system }

enum NotificationKind { lesson, test, payment, attendance }

class StudentNotification {
  const StudentNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.category,
    required this.kind,
    this.isUnread = false,
  });

  final String id;
  final String title;
  final String message;
  final String timeAgo;
  final NotificationCategory category;
  final NotificationKind kind;
  final bool isUnread;

  StudentNotification copyWith({bool? isUnread}) {
    return StudentNotification(
      id: id,
      title: title,
      message: message,
      timeAgo: timeAgo,
      category: category,
      kind: kind,
      isUnread: isUnread ?? this.isUnread,
    );
  }
}
