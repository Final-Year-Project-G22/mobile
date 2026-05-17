import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/constants/app_colors.dart';
import '../../app/constants/app_spacing.dart';

/// Branded loading indicator with a rotating gradient arc.
///
/// Uses the app's accent gradient ([AppColors.accentGradient]) for the
/// spinning stroke and the active [ColorScheme] for the track ring,
/// ensuring consistent theming in both light and dark modes.
///
/// Lifecycle:
/// - Pauses animation when the widget is not visible (e.g. off-screen in
///   a list, navigated away).
/// - Disposes the controller to avoid leaks on permanent removal.
class AdisuProgressIndicator extends StatefulWidget {
  const AdisuProgressIndicator({
    this.size = 36,
    this.strokeWidth,
    this.label,
    super.key,
  });

  /// Compact variant for inline use (e.g. inside buttons).
  const AdisuProgressIndicator.small({
    this.size = 20,
    this.strokeWidth,
    this.label,
    super.key,
  });

  /// Full-screen / page-level size.
  const AdisuProgressIndicator.large({
    this.size = 48,
    this.strokeWidth,
    this.label,
    super.key,
  });

  /// Outer diameter of the ring.
  final double size;

  /// Stroke width. Defaults to size / 12.
  final double? strokeWidth;

  /// Optional text label shown below the ring.
  final String? label;

  @override
  State<AdisuProgressIndicator> createState() => _AdisuProgressIndicatorState();
}

class _AdisuProgressIndicatorState extends State<AdisuProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _rotation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    unawaited(_controller.repeat());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final stroke =
        widget.strokeWidth ?? (widget.size / 12).roundToDouble().clamp(2, 4);

    final ring = SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _rotation,
        builder: (context, _) {
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _SpinningRingPainter(
              rotation: _rotation.value,
              strokeWidth: stroke,
              trackColor: colorScheme.surfaceContainerHigh,
              startColor: AppColors.accentGradient.colors.first,
              endColor: AppColors.accentGradient.colors.last,
            ),
          );
        },
      ),
    );

    if (widget.label == null) return ring;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ring,
        AppSpacing.gapVerticalSm,
        Text(
          widget.label!,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SpinningRingPainter extends CustomPainter {
  _SpinningRingPainter({
    required this.rotation,
    required this.strokeWidth,
    required this.trackColor,
    required this.startColor,
    required this.endColor,
  });

  final double rotation;
  final double strokeWidth;
  final Color trackColor;
  final Color startColor;
  final Color endColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background track ring (full circle, subtle).
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // Spinning gradient arc.
    const arcLength =
        math.pi * 1.4; // ~250° — not a full circle for motion feel
    final startAngle = rotation;

    final arcPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        endAngle: arcLength,
        colors: [
          startColor.withValues(alpha: 0.1),
          endColor,
          startColor,
        ],
      ).createShader(rect);

    canvas.drawArc(rect, startAngle, arcLength, false, arcPaint);
  }

  @override
  bool shouldRepaint(_SpinningRingPainter oldDelegate) =>
      oldDelegate.rotation != rotation ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.startColor != startColor ||
      oldDelegate.endColor != endColor;
}
