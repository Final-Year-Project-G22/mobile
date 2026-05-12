import 'package:flutter/material.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLocked = step.status == StepStatus.locked;
    final isCompleted = step.status == StepStatus.completed;
    final isCurrent = step.status == StepStatus.inProgress;
    final isSkipped = step.status == StepStatus.skipped;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    _buildCircle(
                      context,
                      isDark,
                      isCompleted,
                      isCurrent,
                      isSkipped,
                      isLocked,
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: isCompleted
                              ? AppColors.success
                              : (isDark
                                    ? AppColors.slate700
                                    : AppColors.slate200),
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
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isLocked
                                    ? (isDark
                                          ? AppColors.slate600
                                          : AppColors.slate400)
                                    : (isDark
                                          ? AppColors.textPrimaryDark
                                          : AppColors.textPrimaryLight),
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
                                color: (isDark
                                    ? AppColors.slate700
                                    : AppColors.slate100),
                                borderRadius: AppSpacing.borderRadiusFull,
                              ),
                              child: Text(
                                '~${step.estimatedTime}m',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
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
                          style: TextStyle(
                            fontSize: 13,
                            color: isLocked
                                ? (isDark
                                      ? AppColors.slate600
                                      : AppColors.slate400)
                                : (isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      AppSpacing.gapVerticalXs,
                      _buildStatusBadge(context, step.status),
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
    BuildContext context,
    bool isDark,
    bool isCompleted,
    bool isCurrent,
    bool isSkipped,
    bool isLocked,
  ) {
    if (isCompleted) {
      return Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, size: 16, color: Colors.white),
      );
    }
    if (isCurrent) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.accent, width: 2.5),
        ),
        child: Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: AppColors.accent,
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
        border: Border.all(
          color: isDark ? AppColors.slate700 : AppColors.slate300,
          width: 2,
        ),
      ),
      child: Icon(
        Icons.lock,
        size: 14,
        color: isDark ? AppColors.slate600 : AppColors.slate400,
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, StepStatus status) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case StepStatus.completed:
        bgColor = AppColors.success.withValues(alpha: 0.15);
        textColor = AppColors.success;
        label = 'Completed';
      case StepStatus.inProgress:
        bgColor = AppColors.accent.withValues(alpha: 0.15);
        textColor = AppColors.accent;
        label = 'In Progress';
      case StepStatus.skipped:
        bgColor = AppColors.warning.withValues(alpha: 0.15);
        textColor = AppColors.warning;
        label = 'Skipped';
      case StepStatus.locked:
        bgColor = isDark ? AppColors.slate700 : AppColors.slate200;
        textColor = isDark ? AppColors.slate500 : AppColors.slate500;
        label = 'Locked';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
