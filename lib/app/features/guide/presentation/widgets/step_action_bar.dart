import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../domain/entities/step_enums.dart';

class StepActionBar extends StatelessWidget {
  const StepActionBar({
    required this.status,
    required this.isOptional,
    required this.isBookmarked,
    super.key,
    this.onStart,
    this.onComplete,
    this.onSkip,
    this.onMarkIncomplete,
    this.onToggleBookmark,
  });

  final StepStatus status;
  final bool isOptional;
  final bool isBookmarked;
  final VoidCallback? onStart;
  final VoidCallback? onComplete;
  final VoidCallback? onSkip;
  final VoidCallback? onMarkIncomplete;
  final VoidCallback? onToggleBookmark;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
      ),
      child: SafeArea(
        child: _buildActions(context, isDark),
      ),
    );
  }

  Widget _buildActions(BuildContext context, bool isDark) {
    switch (status) {
      case StepStatus.locked:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? AppColors.slate700 : AppColors.slate200,
              foregroundColor: isDark ? AppColors.slate500 : AppColors.slate400,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: AppSpacing.borderRadiusMd,
              ),
            ),
            child: const Text('Complete previous steps first'),
          ),
        );
      case StepStatus.inProgress:
        return Row(
          children: [
            if (isOptional)
              Expanded(
                child: OutlinedButton(
                  onPressed: onSkip,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.accent,
                    side: const BorderSide(color: AppColors.accent),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                  ),
                  child: const Text('Skip'),
                ),
              ),
            if (isOptional) AppSpacing.gapHorizontalSm,
            Expanded(
              flex: isOptional ? 2 : 1,
              child: ElevatedButton(
                onPressed: onComplete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                ),
                child: const Text('Complete Step'),
              ),
            ),
            AppSpacing.gapHorizontalSm,
            IconButton(
              onPressed: onToggleBookmark,
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked
                    ? AppColors.accent
                    : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              ),
              tooltip: isBookmarked ? 'Remove bookmark' : 'Add bookmark',
            ),
          ],
        );
      case StepStatus.completed:
        return Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onMarkIncomplete,
                icon: const Icon(Icons.undo, size: 18),
                label: const Text('Mark Incomplete'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.warning,
                  side: const BorderSide(color: AppColors.warning),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                ),
              ),
            ),
            AppSpacing.gapHorizontalSm,
            IconButton(
              onPressed: onToggleBookmark,
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked
                    ? AppColors.accent
                    : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              ),
              tooltip: isBookmarked ? 'Remove bookmark' : 'Add bookmark',
            ),
          ],
        );
      case StepStatus.skipped:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onStart,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: AppSpacing.borderRadiusMd,
              ),
            ),
            child: const Text('Start Step'),
          ),
        );
    }
  }
}
