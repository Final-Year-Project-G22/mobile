import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularProgressRing extends StatelessWidget {
  const CircularProgressRing({
    required this.percent,
    this.size = 120,
    this.strokeWidth = 10,
    this.color,
    this.backgroundColor,
    this.label,
    super.key,
  });

  final double percent;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progressColor = color ?? (isDark ? const Color(0xFF60A5FA) : const Color(0xFF3B82F6));
    final trackColor = backgroundColor ?? (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0));

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              percent: percent.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              color: progressColor,
              backgroundColor: trackColor,
            ),
          ),
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                fontSize: size * 0.28,
                fontWeight: FontWeight.w700,
                color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
              ),
            ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.percent,
    required this.strokeWidth,
    required this.color,
    required this.backgroundColor,
  });

  final double percent;
  final double strokeWidth;
  final Color color;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    if (percent > 0) {
      final progressPaint = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * percent,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.percent != percent ||
      oldDelegate.color != color ||
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.strokeWidth != strokeWidth;
}
