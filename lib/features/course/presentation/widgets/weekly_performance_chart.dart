import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class WeeklyPerformanceChart extends StatelessWidget {
  const WeeklyPerformanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: CustomPaint(
        painter: _WeeklyPerformanceChartPainter(),
        child: Container(),
      ),
    );
  }
}

class _WeeklyPerformanceChartPainter extends CustomPainter {
  final List<String> xLabels = ['W1', 'W2', 'W3', 'W4', 'W5', 'W6'];
  final List<double> yLabels = [0, 25, 50, 75, 100];
  final List<double> values = [60, 65, 72, 67, 76, 82];

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final paintDot = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final paintDotBorder = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    final paintGrid = Paint()
      ..color = Colors.grey.withValues(alpha: 0.18)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final paintAxis = Paint()
      ..color = Colors.grey.withValues(alpha: 0.4)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final textStyle = TextStyle(
      color: AppColors.textLight,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    );

    // Padding parameters
    const double paddingLeft = 36.0;
    const double paddingRight = 16.0;
    const double paddingTop = 10.0;
    const double paddingBottom = 28.0;

    final double chartWidth = size.width - paddingLeft - paddingRight;
    final double chartHeight = size.height - paddingTop - paddingBottom;

    // Y Axis parameters
    const double minY = 0.0;
    const double maxY = 100.0;
    const double rangeY = maxY - minY;

    // Draw vertical and horizontal axis lines
    final double bottomY = size.height - paddingBottom;
    canvas.drawLine(
      Offset(paddingLeft, paddingTop),
      Offset(paddingLeft, bottomY),
      paintAxis,
    );
    canvas.drawLine(
      Offset(paddingLeft, bottomY),
      Offset(size.width - paddingRight, bottomY),
      paintAxis,
    );

    // 1. Draw Grid Lines & Y-axis labels & ticks
    for (int i = 0; i < yLabels.length; i++) {
      final double yVal = yLabels[i];
      final double ratio = (yVal - minY) / rangeY;
      final double yPos = bottomY - (ratio * chartHeight);

      // Draw Dashed Grid Line
      double startX = paddingLeft;
      const double dashWidth = 3.0;
      const double dashSpace = 3.0;
      while (startX < size.width - paddingRight) {
        canvas.drawLine(
          Offset(startX, yPos),
          Offset(startX + dashWidth, yPos),
          paintGrid,
        );
        startX += dashWidth + dashSpace;
      }

      // Draw Tick on Y-axis
      canvas.drawLine(
        Offset(paddingLeft - 4, yPos),
        Offset(paddingLeft, yPos),
        paintAxis,
      );

      // Draw Y-Label text
      final textPainter = TextPainter(
        text: TextSpan(text: yVal.toInt().toString(), style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(
          paddingLeft - textPainter.width - 8,
          yPos - textPainter.height / 2,
        ),
      );
    }

    // 2. Plot Points & X-axis labels & ticks
    final List<Offset> points = [];
    final double stepX = chartWidth / (xLabels.length - 1);

    for (int i = 0; i < values.length; i++) {
      final double xPos = paddingLeft + (i * stepX);

      // Calculate Y coordinate
      final double ratio = (values[i] - minY) / rangeY;
      final double yPos = bottomY - (ratio * chartHeight);

      points.add(Offset(xPos, yPos));

      // Draw Tick on X-axis
      canvas.drawLine(
        Offset(xPos, bottomY),
        Offset(xPos, bottomY + 4),
        paintAxis,
      );

      // Draw X-Label text
      final textPainter = TextPainter(
        text: TextSpan(text: xLabels[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(xPos - textPainter.width / 2, bottomY + 8),
      );
    }

    // 3. Draw connecting line
    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, paintLine);

    // 4. Draw dots on top
    for (final point in points) {
      canvas.drawCircle(point, 5, paintDot);
      canvas.drawCircle(point, 5, paintDotBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
