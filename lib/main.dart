import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/routes/app_routes.dart';
import 'core/responsive/app_responsive.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toppers Academy Student',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: AppBreakpoints.values,
      ),
      initialRoute: AppRoutes.signIn,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
