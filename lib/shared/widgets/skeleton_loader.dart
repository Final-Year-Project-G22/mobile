import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/constants/app_spacing.dart';

/// Shimmer skeleton placeholder for loading states.
///
/// Uses an infinite linear gradient animation (1500ms) per DESIGN.md.
class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({
    this.width,
    this.height = 16,
    this.borderRadius,
    super.key,
  });

  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
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
    final baseColor = colorScheme.surfaceContainerHigh;
    final highlightColor = colorScheme.surfaceContainerLow;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? AppSpacing.borderRadiusSm,
            gradient: LinearGradient(
              begin: Alignment(-1.0 + 2.0 * _controller.value, 0),
              end: Alignment(1.0 + 2.0 * _controller.value, 0),
              colors: [baseColor, highlightColor, baseColor],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Pre-built skeleton patterns
// ═══════════════════════════════════════════════════════════════════════

/// Card-shaped skeleton placeholder.
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({this.height = 120, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      width: double.infinity,
      height: height,
      borderRadius: AppSpacing.borderRadiusMd,
    );
  }
}

/// List-tile skeleton with avatar circle + text lines.
class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenH,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          SkeletonLoader(
            width: 44,
            height: 44,
            borderRadius: BorderRadius.circular(22),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(
                  width: double.infinity,
                  height: 14,
                  borderRadius: AppSpacing.borderRadiusXs,
                ),
                const SizedBox(height: AppSpacing.xs),
                SkeletonLoader(
                  width: 160,
                  height: 10,
                  borderRadius: AppSpacing.borderRadiusXs,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Single text-line skeleton.
class SkeletonText extends StatelessWidget {
  const SkeletonText({
    this.width = double.infinity,
    this.height = 14,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      width: width,
      height: height,
      borderRadius: AppSpacing.borderRadiusXs,
    );
  }
}
