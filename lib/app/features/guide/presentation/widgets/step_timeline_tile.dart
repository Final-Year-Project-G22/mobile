import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/status_badge.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../domain/entities/guide_step.dart';
import '../../domain/entities/step_enums.dart';

class StepTimelineTile extends StatelessWidget {
  const StepTimelineTile({
    required this.step,
    required this.index,
    required this.isLast,
    super.key,
    this.onTap,
  });

  final GuideStep step;
  final int index;
  final bool isLast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final isLocked = step.status == StepStatus.locked;
    final isCompleted = step.status == StepStatus.completed;
    final isCurrent = step.status == StepStatus.inProgress;
    final isSkipped = step.status == StepStatus.skipped;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    _buildCircle(
                      colorScheme,
                      isCompleted: isCompleted,
                      isCurrent: isCurrent,
                      isSkipped: isSkipped,
                      isLocked: isLocked,
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: isCompleted
                              ? colorScheme.secondary
                              : colorScheme.outlineVariant,
                        ),
                      ),
                  ],
                ),
              ),
              AppSpacing.gapHorizontalSm,
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              step.title,
                              style: textTheme.titleSmall?.copyWith(
                                color: isLocked
                                    ? colorScheme.onSurfaceVariant.withValues(
                                        alpha: 0.5,
                                      )
                                    : colorScheme.onSurface,
                              ),
                            ),
                          ),
                          if (step.estimatedTime != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHigh,
                                borderRadius: AppSpacing.borderRadiusFull,
                              ),
                              child: Text(
                                l10n.stepEstimatedTime(
                                  '${step.estimatedTime}',
                                ),
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (step.description != null) ...[
                        AppSpacing.gapVerticalXxs,
                        Text(
                          step.description!
                              .replaceAll(RegExp(r'<br\s*/?>'), '\n')
                              .replaceAll(RegExp('</?p>'), '')
                              .replaceAll(RegExp('<[^>]*>'), '')
                              .replaceAll('&nbsp;', ' ')
                              .trim(),
                          style: textTheme.bodySmall?.copyWith(
                            color: isLocked
                                ? colorScheme.onSurfaceVariant.withValues(
                                    alpha: 0.5,
                                  )
                                : colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      AppSpacing.gapVerticalXs,
                      _buildStatusBadge(context, step.status, l10n),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircle(
    ColorScheme colorScheme, {
    required bool isCompleted,
    required bool isCurrent,
    required bool isSkipped,
    required bool isLocked,
  }) {
    if (isCompleted) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check, size: 16, color: colorScheme.onSecondary),
      );
    }
    if (isCurrent) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colorScheme.primary, width: 2.5),
        ),
        child: Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
    if (isSkipped) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.warning, width: 2),
        ),
        child: const Icon(Icons.skip_next, size: 16, color: AppColors.warning),
      );
    }
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colorScheme.outlineVariant, width: 2),
      ),
      child: Icon(
        Icons.lock,
        size: 14,
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
      ),
    );
  }

  Widget _buildStatusBadge(
    BuildContext context,
    StepStatus status,
    AppLocalizations l10n,
  ) {
    final statusType = switch (status) {
      StepStatus.completed => StatusType.completed,
      StepStatus.inProgress => StatusType.inProgress,
      StepStatus.skipped => StatusType.inProgress, // uses amber via override
      StepStatus.locked => StatusType.notStarted,
    };

    final label = switch (status) {
      StepStatus.completed => l10n.stepStatusCompleted,
      StepStatus.inProgress => l10n.stepStatusInProgress,
      StepStatus.skipped => l10n.stepStatusSkipped,
      StepStatus.locked => l10n.stepStatusLocked,
    };

    return StatusBadge(status: statusType, label: label);
  }
}
