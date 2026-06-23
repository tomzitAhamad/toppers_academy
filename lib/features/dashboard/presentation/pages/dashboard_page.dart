import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/responsive/app_responsive.dart';
import '../widgets/home_dashboard_view.dart';
import '../../../course/presentation/pages/course_details_page.dart';
import '../../../library/presentation/pages/library_page.dart';
import '../../../attendance/presentation/pages/attendance_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class DashboardPage extends StatefulWidget {
  final int initialTab;
  const DashboardPage({super.key, this.initialTab = 0});

  static DashboardPageState? of(BuildContext context) {
    return context.findAncestorStateOfType<DashboardPageState>();
  }

  @override
  State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  static const List<_DashboardDestination> _destinations = [
    _DashboardDestination(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      page: HomeDashboardView(key: PageStorageKey('home-page')),
    ),
    _DashboardDestination(
      label: 'Course',
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book,
      page: CourseDetailsPage(key: PageStorageKey('course-page'), isTab: true),
    ),
    _DashboardDestination(
      label: 'Library',
      icon: Icons.library_books_outlined,
      activeIcon: Icons.library_books,
      page: LibraryPage(key: PageStorageKey('library-page'), isTab: true),
    ),
    _DashboardDestination(
      label: 'Attendance',
      icon: Icons.calendar_month_outlined,
      activeIcon: Icons.calendar_month,
      page: AttendancePage(key: PageStorageKey('attendance-page'), isTab: true),
    ),
    _DashboardDestination(
      label: 'Profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      page: ProfilePage(key: PageStorageKey('profile-page')),
    ),
  ];

  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  late int _currentIndex;

  void changeTab(int index) {
    if (index == _currentIndex || index < 0 || index >= _destinations.length) {
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    final useNavigationRail = AppResponsive.useNavigationRail(context);

    final pageBody = PageStorage(
      bucket: _pageStorageBucket,
      child: PageTransitionSwitcher(
        duration: AppAnimations.standard,
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            fillColor: const Color(0xFFF5F6FA),
            child: child,
          );
        },
        child: KeyedSubtree(
          key: ValueKey(_currentIndex),
          child: _destinations[_currentIndex].page,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: useNavigationRail
          ? Row(
              children: [
                SafeArea(
                  right: false,
                  child: NavigationRail(
                    selectedIndex: _currentIndex,
                    onDestinationSelected: changeTab,
                    extended: AppResponsive.isDesktop(context),
                    minExtendedWidth: 210,
                    backgroundColor: Colors.white,
                    indicatorColor: const Color(0xFFE9E7FF),
                    selectedIconTheme: const IconThemeData(
                      color: Color(0xFF4F46FF),
                    ),
                    unselectedIconTheme: const IconThemeData(
                      color: Color(0xFF8A94A6),
                    ),
                    selectedLabelTextStyle: const TextStyle(
                      color: Color(0xFF4F46FF),
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelTextStyle: const TextStyle(
                      color: Color(0xFF8A94A6),
                      fontWeight: FontWeight.w500,
                    ),
                    destinations: _destinations
                        .map(
                          (destination) => NavigationRailDestination(
                            icon: Icon(destination.icon),
                            selectedIcon: Icon(destination.activeIcon),
                            label: Text(destination.label),
                          ),
                        )
                        .toList(growable: false),
                  ),
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: pageBody),
              ],
            )
          : pageBody,
      bottomNavigationBar: useNavigationRail
          ? null
          : Container(
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
                currentIndex: _currentIndex,
                onTap: changeTab,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: const Color(0xFF4F46FF),
                unselectedItemColor: const Color(0xFF8A94A6),
                selectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                items: _destinations
                    .map(
                      (destination) => BottomNavigationBarItem(
                        icon: Icon(destination.icon),
                        activeIcon: Icon(destination.activeIcon),
                        label: destination.label,
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
    );
  }
}

class _DashboardDestination {
  const _DashboardDestination({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.page,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final Widget page;
}
