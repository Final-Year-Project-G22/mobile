import 'package:flutter/material.dart';

import '../../../../../shared/widgets/circular_progress_ring.dart';
import '../../../../constants/app_spacing.dart';
import '../../../guide/domain/entities/guide_with_progress.dart';

class ContinueGuideCard extends StatelessWidget {
  const ContinueGuideCard({
    required this.guide,
    this.onTap,
    super.key,
  });

  final GuideWithProgress guide;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 144,
      child: Card(
        // Inherits CardTheme defaults (elevation, shape, no border)
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSpacing.borderRadiusMd,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressRing(
                  percent: guide.percent,
                  size: 42,
                  strokeWidth: 4,
                  label: '${(guide.percent * 100).round()}%',
                ),
                AppSpacing.gapVerticalXxs,
                Text(
                  guide.name,
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
