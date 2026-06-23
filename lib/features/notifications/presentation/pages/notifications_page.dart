import 'package:flutter/material.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/student_notification.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../controllers/notification_controller.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_filter_bar.dart';
import '../widgets/notification_header.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final NotificationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NotificationController()..addListener(_refresh);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  void _openDashboardTab(int index) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => DashboardPage(initialTab: index)),
      (route) => false,
    );
  }

  void _goBack() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      _openDashboardTab(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifications = _controller.visibleNotifications;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              primary: true,
              elevation: 0,
              backgroundColor: const Color(0xFFF7F8FA),
              expandedHeight: 169.0 + statusBarHeight,
              toolbarHeight: 0,
              collapsedHeight: 55.0 + statusBarHeight,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double currentHeight = constraints.maxHeight;
                  final double minH = 55.0 + statusBarHeight;
                  final double maxH = 169.0 + statusBarHeight;
                  final double t = ((currentHeight - minH) / (maxH - minH))
                      .clamp(0.0, 1.0);

                  return Stack(
                    children: [
                      // Gradient header container
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: currentHeight,
                        child: Opacity(
                          opacity: t,
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: SizedBox(
                              height: 120.0 + statusBarHeight + 8,
                              child: NotificationHeader(
                                unreadCount: _controller.unreadCount,
                                onBack: _goBack,
                                topPadding: statusBarHeight + 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(55),
                child: Container(
                  color: const Color(0xFFF7F8FA),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: NotificationFilterBar(
                    selectedFilter: _controller.selectedFilter,
                    onSelected: _controller.selectFilter,
                  ),
                ),
              ),
            ),
          ];
        },
        body: AnimatedSwitcher(
          duration: AppAnimations.standard,
          switchInCurve: AppAnimations.enterCurve,
          switchOutCurve: AppAnimations.exitCurve,
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: notifications.isEmpty
              ? const _EmptyNotifications(key: ValueKey('empty-notifications'))
              : ListView.separated(
                  key: ValueKey(_controller.selectedFilter),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  itemCount: notifications.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    final card = NotificationCard(
                      notification: notification,
                      onTap: () {
                        _controller.markAsRead(notification.id);
                        if (notification.kind == NotificationKind.test) {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.mockTestDetails);
                        }
                      },
                    );

                    return AppReveal(
                      key: ValueKey(
                        '${_controller.selectedFilter.name}-${notification.id}',
                      ),
                      delay: Duration(milliseconds: 85 * index),
                      duration: const Duration(milliseconds: 500),
                      offset: const Offset(0, 0.08),
                      beginScale: 0.98,
                      beginOpacity: 0,
                      child: card,
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar: _NotificationBottomBar(
        onSelected: _openDashboardTab,
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            color: AppColors.textLight,
            size: 44,
          ),
          SizedBox(height: 10),
          Text(
            'No notifications here',
            style: TextStyle(
              color: AppColors.textMedium,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationBottomBar extends StatelessWidget {
  const _NotificationBottomBar({required this.onSelected});

  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        onTap: onSelected,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF8A94A6),
        unselectedItemColor: const Color(0xFF8A94A6),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
