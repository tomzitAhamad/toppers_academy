import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF4F39F6); // Vibrant Indigo
  static const Color primaryLight = Color(0xFFEEF2F6);
  static const Color secondary = Color(0xFF06B6D4); // Cyan

  // Backgrounds
  static const Color background = Color(0xFFF8FAFC);
  static const Color cardBackground = Colors.white;
  static const Color inputBackground = Color(0xFFF1F5F9);

  // Text Colors
  static const Color textDark = Color(0xFF0F172A); // Slate 900
  static const Color textMedium = Color(0xFF475569); // Slate 600
  static const Color textLight = Color(0xFF94A3B8); // Slate 400

  // Indicators & Badges
  static const Color activeGreen = Color(0xFF10B981);
  static const Color activeGreenBg = Color(0xFFD1FAE5);
  static const Color warningOrange = Color(0xFFF97316);
  static const Color warningOrangeBg = Color(0xFFFFEDD5);
  static const Color alertRed = Color(0xFFEF4444);
  static const Color alertRedBg = Color(0xFFFEE2E2);
  static const Color goldLight = Color(0xFFFEF3C7);
  static const Color goldDark = Color(0xFFD97706);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF4F39F6), // Rich cobalt blue
      Color(0xFF6E12B1), // Rich magenta purple
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient loginBackgroundGradient = LinearGradient(
    colors: [
      Color(0xFF4F39F6), // Rich cobalt blue
      Color(0xFF6E12B1), // Rich magenta purple
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient upcomingLiveGradient = LinearGradient(
    colors: [
      Color(0xFF06B6D4), // Cyan
      Color(0xFF3B82F6), // Blue
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient orangeProgressGradient = LinearGradient(
    colors: [
      Color(0xFFF97316), // Orange
      Color(0xFFFDBA74), // Light Orange
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
