import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toppers_academy_student/core/animations/app_animations.dart';
import 'package:toppers_academy_student/core/routes/app_routes.dart';
import 'package:toppers_academy_student/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:toppers_academy_student/features/mock_test/presentation/pages/mock_tests_list_page.dart';
import 'package:toppers_academy_student/features/notifications/presentation/pages/notifications_page.dart';
import 'package:toppers_academy_student/features/profile/presentation/widgets/profile_payment_history_card.dart';
import 'package:toppers_academy_student/core/responsive/app_responsive.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUpAll(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets('animated digits count from zero to the target', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppAnimatedNumber(
            value: 68,
            suffix: '%',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );

    expect(find.text('0%'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('68%'), findsOneWidget);
  });

  testWidgets('animated progress grows from zero to the target', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppAnimatedLinearProgress(
            value: 0.75,
            color: Colors.green,
            backgroundColor: Colors.grey,
          ),
        ),
      ),
    );

    expect(
      tester
          .widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator))
          .value,
      0,
    );

    await tester.pumpAndSettle();

    expect(
      tester
          .widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator))
          .value,
      closeTo(0.75, 0.001),
    );
  });

  testWidgets('filters notifications by category', (tester) async {
    tester.view.physicalSize = const Size(378, 840);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: NotificationsPage()));

    expect(find.text('2 unread notifications'), findsOneWidget);
    expect(find.text('New Lesson Available'), findsOneWidget);
    expect(find.text('Mock Test Reminder'), findsOneWidget);

    await tester.tap(find.text('Courses'));
    await tester.pumpAndSettle();

    expect(find.text('New Lesson Available'), findsOneWidget);
    expect(find.text('Live Class Starting Soon'), findsOneWidget);
    expect(find.text('Mock Test Reminder'), findsNothing);
  });

  testWidgets('shows the correct test, payment, and system notifications', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(388, 840);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: NotificationsPage()));

    await tester.tap(find.text('Tests'));
    await tester.pumpAndSettle();
    expect(find.text('Mock Test Reminder'), findsOneWidget);
    expect(find.text('Mock Test Result Available'), findsOneWidget);

    await tester.tap(find.text('Payment'));
    await tester.pumpAndSettle();
    expect(find.text('Payment Due Reminder'), findsOneWidget);
    expect(find.text('Mock Test Reminder'), findsNothing);

    await tester.tap(find.text('System'));
    await tester.pumpAndSettle();
    expect(find.text('Attendance Alert'), findsOneWidget);
    expect(find.text('Payment Due Reminder'), findsNothing);
  });

  testWidgets('marks an unread notification as read', (tester) async {
    tester.view.physicalSize = const Size(378, 840);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: NotificationsPage()));

    await tester.tap(find.text('New Lesson Available'));
    await tester.pump();

    expect(find.text('1 unread notifications'), findsOneWidget);
  });

  testWidgets('bottom navigation switches destinations safely', (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) =>
            MediaQuery.withNoTextScaling(child: child!),
        home: const DashboardPage(),
      ),
    );

    expect(
      tester
          .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
          .currentIndex,
      0,
    );

    await tester.tap(find.text('Course'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
          .currentIndex,
      1,
    );

    await tester.tap(find.text('Course'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(
      tester
          .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
          .currentIndex,
      0,
    );
  });

  testWidgets('wide screens use a navigation rail', (tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => ResponsiveBreakpoints.builder(
          breakpoints: AppBreakpoints.values,
          child: child!,
        ),
        home: const DashboardPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsNothing);
  });

  testWidgets('landscape phones keep bottom navigation', (tester) async {
    tester.view.physicalSize = const Size(844, 390);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => ResponsiveBreakpoints.builder(
          breakpoints: AppBreakpoints.values,
          child: child!,
        ),
        home: const DashboardPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(NavigationRail), findsNothing);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('payment history stays responsive at compact widths', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 251,
              child: ProfilePaymentHistoryCard(
                payments: [
                  ProfilePaymentItem(
                    title: 'Course Fee - Installment 1',
                    date: 'Mar 1, 2026',
                    amount: '৳4,000',
                    isGreen: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Course Fee - Installment 1'), findsOneWidget);
    expect(find.text('৳4,000'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Start Test opens the active listening test', (tester) async {
    tester.view.physicalSize = const Size(440, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: AppRoutes.generateRoute,
        home: const MockTestsListPage(),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Start Test'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Start Test'));
    await tester.pumpAndSettle();

    expect(find.text('Listening'), findsWidgets);
    expect(find.text('Question 1'), findsOne);
    expect(find.text('Audio Track 1'), findsOne);
    expect(find.text('Your answers are automatically saved'), findsOne);
  });
}
