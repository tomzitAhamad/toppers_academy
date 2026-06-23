import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

abstract final class AppBreakpoints {
  static const String compact = 'COMPACT';
  static const String mobile = MOBILE;
  static const String tablet = TABLET;
  static const String desktop = DESKTOP;

  static const List<Breakpoint> values = [
    Breakpoint(start: 0, end: 359, name: compact),
    Breakpoint(start: 360, end: 599, name: mobile),
    Breakpoint(start: 600, end: 1023, name: tablet),
    Breakpoint(start: 1024, end: 1919, name: desktop),
    Breakpoint(start: 1920, end: double.infinity, name: '4K'),
  ];
}

abstract final class AppResponsive {
  static ResponsiveBreakpointsData? _breakpoints(BuildContext context) {
    try {
      return ResponsiveBreakpoints.of(context);
    } on FlutterError {
      return null;
    }
  }

  static bool isCompact(BuildContext context) =>
      _breakpoints(context)?.equals(AppBreakpoints.compact) ??
      MediaQuery.sizeOf(context).width < 360;

  static bool isTablet(BuildContext context) =>
      _breakpoints(context)?.isTablet ?? false;

  static bool isDesktop(BuildContext context) =>
      _breakpoints(context)?.largerOrEqualTo(DESKTOP) ?? false;

  static bool useNavigationRail(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide >= 600;

  static double horizontalPadding(BuildContext context) {
    if (isDesktop(context)) return 32;
    if (isTablet(context)) return 24;
    if (isCompact(context)) return 12;
    return 16;
  }

  static double contentMaxWidth(BuildContext context) {
    if (isDesktop(context)) return 1200;
    if (isTablet(context)) return 840;
    return double.infinity;
  }
}

class AppResponsiveContent extends StatelessWidget {
  const AppResponsiveContent({
    required this.child,
    this.maxWidth,
    this.padding,
    super.key,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? AppResponsive.contentMaxWidth(context),
        ),
        child: Padding(
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: AppResponsive.horizontalPadding(context),
              ),
          child: child,
        ),
      ),
    );
  }
}
