import 'dart:math' as math;
import 'package:flutter/material.dart';

class SkillsRadarChart extends StatelessWidget {
  final double listening;
  final double reading;
  final double writing;
  final double speaking;

  const SkillsRadarChart({
    super.key,
    required this.listening,
    required this.reading,
    required this.writing,
    required this.speaking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomPaint(
        painter: _RadarChartPainter(
          listening: listening,
          reading: reading,
          writing: writing,
          speaking: speaking,
        ),
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final double listening;
  final double reading;
  final double writing;
  final double speaking;

  _RadarChartPainter({
    required this.listening,
    required this.reading,
    required this.writing,
    required this.speaking,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) * 0.35;

    // Paints
    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final axisPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final scoreFillPaint = Paint()
      ..color = const Color(0xFF4F46FF).withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    final scoreOutlinePaint = Paint()
      ..color = const Color(0xFF4F46FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // 1. Draw Concentric Grid Diamonds (representing score increments: 3, 6, 9)
    final gridLevels = [3.0, 6.0, 9.0];
    for (final level in gridLevels) {
      final radius = (level / 9.0) * maxRadius;
      final path = Path()
        ..moveTo(center.dx, center.dy - radius) // Top
        ..lineTo(center.dx + radius, center.dy) // Right
        ..lineTo(center.dx, center.dy + radius) // Bottom
        ..lineTo(center.dx - radius, center.dy) // Left
        ..close();
      canvas.drawPath(path, gridPaint);

      // Draw tick number on the axis
      _drawText(
        canvas,
        level.toInt().toString(),
        Offset(center.dx + 4, center.dy - radius - 6),
        fontSize: 9,
        fontWeight: FontWeight.w600,
        textColor: const Color(0xFF94A3B8),
      );
    }

    // 2. Draw Axes (Lines from center to vertex of max diamond)
    // Listening Axis (Top)
    canvas.drawLine(
      center,
      Offset(center.dx, center.dy - maxRadius),
      axisPaint,
    );
    // Reading Axis (Right)
    canvas.drawLine(
      center,
      Offset(center.dx + maxRadius, center.dy),
      axisPaint,
    );
    // Writing Axis (Bottom)
    canvas.drawLine(
      center,
      Offset(center.dx, center.dy + maxRadius),
      axisPaint,
    );
    // Speaking Axis (Left)
    canvas.drawLine(
      center,
      Offset(center.dx - maxRadius, center.dy),
      axisPaint,
    );

    // 3. Draw Axis Labels
    // Listening (Top)
    _drawText(
      canvas,
      'Listening',
      Offset(center.dx, center.dy - maxRadius - 20),
      fontSize: 11,
      fontWeight: FontWeight.w700,
      textColor: const Color(0xFF475569),
      alignCenter: true,
    );
    // Reading (Right)
    _drawText(
      canvas,
      'Reading',
      Offset(center.dx + maxRadius + 8, center.dy),
      fontSize: 11,
      fontWeight: FontWeight.w700,
      textColor: const Color(0xFF475569),
      alignCenter: false,
    );
    // Writing (Bottom)
    _drawText(
      canvas,
      'Writing',
      Offset(center.dx, center.dy + maxRadius + 8),
      fontSize: 11,
      fontWeight: FontWeight.w700,
      textColor: const Color(0xFF475569),
      alignCenter: true,
    );
    // Speaking (Left)
    _drawText(
      canvas,
      'Speaking',
      Offset(center.dx - maxRadius - 55, center.dy),
      fontSize: 11,
      fontWeight: FontWeight.w700,
      textColor: const Color(0xFF475569),
      alignCenter: false,
    );

    // 4. Calculate Score Coordinates (Clamped between 0 and 9)
    final lScore = listening.clamp(0.0, 9.0);
    final rScore = reading.clamp(0.0, 9.0);
    final wScore = writing.clamp(0.0, 9.0);
    final sScore = speaking.clamp(0.0, 9.0);

    final lRadius = (lScore / 9.0) * maxRadius;
    final rRadius = (rScore / 9.0) * maxRadius;
    final wRadius = (wScore / 9.0) * maxRadius;
    final sRadius = (sScore / 9.0) * maxRadius;

    final lPoint = Offset(center.dx, center.dy - lRadius);
    final rPoint = Offset(center.dx + rRadius, center.dy);
    final wPoint = Offset(center.dx, center.dy + wRadius);
    final sPoint = Offset(center.dx - sRadius, center.dy);

    // 5. Draw Score Polygon
    final scorePath = Path()
      ..moveTo(lPoint.dx, lPoint.dy)
      ..lineTo(rPoint.dx, rPoint.dy)
      ..lineTo(wPoint.dx, wPoint.dy)
      ..lineTo(sPoint.dx, sPoint.dy)
      ..close();

    canvas.drawPath(scorePath, scoreFillPaint);
    canvas.drawPath(scorePath, scoreOutlinePaint);

    // 6. Draw Score Points (Circles)
    final dotPaint = Paint()
      ..color = const Color(0xFF4F46FF)
      ..style = PaintingStyle.fill;
    final dotOuterPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final points = [lPoint, rPoint, wPoint, sPoint];
    for (final point in points) {
      canvas.drawCircle(point, 5.0, dotPaint);
      canvas.drawCircle(point, 5.0, dotOuterPaint);
    }
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset position, {
    required double fontSize,
    required FontWeight fontWeight,
    required Color textColor,
    bool alignCenter = false,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final offset = alignCenter
        ? Offset(position.dx - textPainter.width / 2, position.dy)
        : Offset(position.dx, position.dy - textPainter.height / 2);

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _RadarChartPainter oldDelegate) {
    return oldDelegate.listening != listening ||
        oldDelegate.reading != reading ||
        oldDelegate.writing != writing ||
        oldDelegate.speaking != speaking;
  }
}
