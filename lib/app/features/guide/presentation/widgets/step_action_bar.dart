import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';
import '../../domain/entities/step_enums.dart';

/// Bottom action bar for step detail page.
///
/// Uses M3 button variants: Filled for primary CTA, Outlined for secondary.
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
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      child: SafeArea(
        child: _buildActions(context),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    switch (status) {
      case StepStatus.locked:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.play_arrow, size: 18),
            label: Text(l10n.stepStart),
          ),
        );

      case StepStatus.inProgress:
        return Row(
          children: [
            if (isOptional)
              Expanded(
                child: OutlinedButton(
                  onPressed: onSkip,
                  child: Text(l10n.stepSkip),
                ),
              ),
            if (isOptional) AppSpacing.gapHorizontalSm,
            Expanded(
              flex: isOptional ? 2 : 1,
              child: ElevatedButton(
                onPressed: onComplete,
                child: Text(l10n.stepComplete),
              ),
            ),
            AppSpacing.gapHorizontalSm,
            IconButton(
              onPressed: onToggleBookmark,
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
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
                  foregroundColor: colorScheme.tertiary,
                  side: BorderSide(color: colorScheme.tertiary),
                ),
              ),
            ),
            AppSpacing.gapHorizontalSm,
            IconButton(
              onPressed: onToggleBookmark,
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
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
            child: Text(l10n.stepStart),
          ),
        );
    }
  }
}
