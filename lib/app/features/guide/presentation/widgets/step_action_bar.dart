import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);

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
        child: _buildActions(context, isDark, l10n),
      ),
    );
  }

  Widget _buildActions(
    BuildContext context,
    bool isDark,
    AppLocalizations l10n,
  ) {
    switch (status) {
      case StepStatus.locked:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.play_arrow, size: 18),
            label: Text(l10n.stepStart),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: AppSpacing.borderRadiusMd,
              ),
            ),
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
                  child: Text(l10n.stepSkip),
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
                child: Text(l10n.stepComplete),
              ),
            ),
            AppSpacing.gapHorizontalSm,
            IconButton(
              onPressed: onToggleBookmark,
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked
                    ? AppColors.accent
                    : (isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight),
              ),
              tooltip: isBookmarked
                  ? l10n.stepRemoveBookmark
                  : l10n.stepAddBookmark,
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
                label: Text(l10n.stepMarkIncomplete),
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
                    : (isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight),
              ),
              tooltip: isBookmarked
                  ? l10n.stepRemoveBookmark
                  : l10n.stepAddBookmark,
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
            child: Text(l10n.stepStart),
          ),
        );
    }
  }
}
