import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/constants/app_colors.dart';
import '../../app/constants/app_spacing.dart';

/// Animated circular progress ring with optional gradient stroke.
///
/// Consumes theme colors by default — no `isDark` checks needed.
/// Plays an entrance animation on first build via [AnimationController].
class CircularProgressRing extends StatefulWidget {
  const CircularProgressRing({
    required this.percent,
    this.size = 120,
    this.strokeWidth = 10,
    this.progressColor,
    this.trackColor,
    this.useGradient = false,
    this.label,
    this.animate = true,
    super.key,
  });

  /// Progress value between 0.0 and 1.0.
  final double percent;

  /// Outer diameter of the ring.
  final double size;

  /// Width of the ring stroke.
  final double strokeWidth;

  /// Override for the progress stroke color (defaults to `colorScheme.secondary`).
  final Color? progressColor;

  /// Override for the track color (defaults to `surfaceContainerHigh`).
  final Color? trackColor;

  /// When true, uses the emerald accent gradient for the stroke.
  final bool useGradient;

  /// Text displayed at the center of the ring.
  final String? label;

  /// Whether to play an entrance animation.
  final bool animate;

  @override
  State<CircularProgressRing> createState() => _CircularProgressRingState();
}

class _CircularProgressRingState extends State<CircularProgressRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppSpacing.durationLong2,
    );
    _buildAnimation();
    if (widget.animate) {
      unawaited(_controller.forward());
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CircularProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent) {
      _buildAnimation();
      unawaited(_controller.forward(from: 0));
    }
  }

  void _buildAnimation() {
    _animation =
        Tween<double>(
          begin: 0,
          end: widget.percent.clamp(0.0, 1.0),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: AppSpacing.curveEaseOut,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedTrack = widget.trackColor ?? colorScheme.surfaceContainerHigh;
    final resolvedProgress = widget.progressColor ?? colorScheme.secondary;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _RingPainter(
                  percent: _animation.value,
                  strokeWidth: widget.strokeWidth,
                  color: resolvedProgress,
                  backgroundColor: resolvedTrack,
                  useGradient: widget.useGradient,
                ),
              ),
              if (widget.label != null) child!,
            ],
          );
        },
        child: widget.label != null
            ? Text(
                widget.label!,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: widget.size * 0.22,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              )
            : null,
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
    this.useGradient = false,
  });

  final double percent;
  final double strokeWidth;
  final Color color;
  final Color backgroundColor;
  final bool useGradient;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw track
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    if (percent > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final sweepAngle = 2 * math.pi * percent;

      final progressPaint = Paint()
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      if (useGradient) {
        progressPaint.shader = SweepGradient(
          startAngle: -math.pi / 2,
          endAngle: 3 * math.pi / 2,
          colors: AppColors.accentGradient.colors,
        ).createShader(rect);
      } else {
        progressPaint.color = color;
      }

      canvas.drawArc(
        rect,
        -math.pi / 2,
        sweepAngle,
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
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.useGradient != useGradient;
}
