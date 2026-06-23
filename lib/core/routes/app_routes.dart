import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/course/presentation/pages/course_details_page.dart';
import '../../features/library/presentation/pages/library_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/mock_test/presentation/pages/mock_test_details_page.dart';
import '../../features/mock_test/presentation/pages/mock_test_active_page.dart';
import '../../features/mock_test/presentation/pages/mock_tests_list_page.dart';
import '../../features/mock_test/presentation/pages/purchase_mock_tests_page.dart';
import '../../features/mock_test/presentation/pages/payment_page.dart';
import '../../features/mock_test/presentation/pages/payment_success_page.dart';
import '../../features/mock_test/presentation/pages/mock_test_result_page.dart';

class AppRoutes {
  static const String signIn = '/sign-in';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String courseDetails = '/course-details';
  static const String library = '/library';
  static const String notifications = '/notifications';
  static const String mockTestDetails = '/mock-test-details';
  static const String mockTestActive = '/mock-test-active';
  static const String mockTestsList = '/mock-tests';
  static const String mockTestPurchase = '/mock-test-purchase';
  static const String payment = '/payment';
  static const String paymentSuccess = '/payment-success';
  static const String mockTestResult = '/mock-test-result';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case courseDetails:
        return MaterialPageRoute(builder: (_) => const CourseDetailsPage());
      case library:
        return MaterialPageRoute(builder: (_) => const LibraryPage());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsPage());
      case mockTestDetails:
        return MaterialPageRoute(builder: (_) => const MockTestDetailsPage());
      case mockTestActive:
        return MaterialPageRoute(builder: (_) => const MockTestActivePage());
      case mockTestsList:
        return MaterialPageRoute(builder: (_) => const MockTestsListPage());
      case mockTestPurchase:
        return MaterialPageRoute(builder: (_) => const PurchaseMockTestsPage());
      case payment:
        return MaterialPageRoute(
          builder: (_) => const PaymentPage(),
          settings: settings,
        );
      case paymentSuccess:
        return MaterialPageRoute(
          builder: (_) => const PaymentSuccessPage(),
          settings: settings,
        );
      case mockTestResult:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => MockTestResultPage(
            overallBand: args['overallBand'] ?? 7.5,
            listeningBand: args['listeningBand'] ?? 7.5,
            readingBand: args['readingBand'] ?? 8.0,
            writingBand: args['writingBand'] ?? 7.0,
            speakingBand: args['speakingBand'] ?? 7.5,
            testTitle: args['testTitle'] ?? 'Mock Test #1',
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
