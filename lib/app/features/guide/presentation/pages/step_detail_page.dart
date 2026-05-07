import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../application/guide_detail_notifier.dart';
import '../../application/step_detail_notifier.dart';
import '../../domain/entities/step_enums.dart';
import '../widgets/step_action_bar.dart';

class StepDetailPage extends ConsumerStatefulWidget {
  const StepDetailPage({
    required this.guideSlug,
    required this.stepSlug,
    super.key,
  });

  final String guideSlug;
  final String stepSlug;

  @override
  ConsumerState<StepDetailPage> createState() => _StepDetailPageState();
}

class _StepDetailPageState extends ConsumerState<StepDetailPage> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(stepDetailProvider.notifier).loadStep(widget.guideSlug, widget.stepSlug);
    });
  }

  void _completeAndReturn() {
    ref.read(stepDetailProvider.notifier).completeStep();
    ref
        .read(guideDetailProvider.notifier)
        .updateStepStatus(
          widget.stepSlug,
          StepStatus.completed,
        );
    Navigator.of(context).pop();
  }

  void _skipAndReturn() {
    ref.read(stepDetailProvider.notifier).skipStep();
    ref
        .read(guideDetailProvider.notifier)
        .updateStepStatus(
          widget.stepSlug,
          StepStatus.skipped,
        );
    Navigator.of(context).pop();
  }

  void _markIncompleteAndReturn() {
    ref.read(stepDetailProvider.notifier).markIncomplete();
    ref
        .read(guideDetailProvider.notifier)
        .updateStepStatus(
          widget.stepSlug,
          StepStatus.inProgress,
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stepDetailProvider);
    final step = state.step;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(step?.title ?? 'Step'),
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      ),
      body: step == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                    border: Border(
                      bottom: BorderSide(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _statusBadge(step.status),
                          if (step.estimatedTime != null) ...[
                            AppSpacing.gapHorizontalSm,
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.slate700 : AppColors.slate100,
                                borderRadius: AppSpacing.borderRadiusFull,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 14,
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                  ),
                                  AppSpacing.gapHorizontalXxs,
                                  Text(
                                    '~${step.estimatedTime} min',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (step.description != null) ...[
                        AppSpacing.gapVerticalSm,
                        Text(
                          step.description!,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: _buildMarkdown(step.detailedContent, isDark),
                  ),
                ),
                StepActionBar(
                  status: step.status,
                  isOptional: step.isOptional,
                  isBookmarked: _isBookmarked,
                  onComplete: _completeAndReturn,
                  onSkip: _skipAndReturn,
                  onMarkIncomplete: _markIncompleteAndReturn,
                  onToggleBookmark: () {
                    setState(() {
                      _isBookmarked = !_isBookmarked;
                    });
                  },
                ),
              ],
            ),
    );
  }

  Widget _statusBadge(StepStatus status) {
    final color = switch (status) {
      StepStatus.completed => AppColors.success,
      StepStatus.inProgress => AppColors.accent,
      StepStatus.skipped => AppColors.warning,
      StepStatus.locked => AppColors.slate500,
    };
    final label = switch (status) {
      StepStatus.completed => 'Completed',
      StepStatus.inProgress => 'In Progress',
      StepStatus.skipped => 'Skipped',
      StepStatus.locked => 'Locked',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
      ),
    );
  }

  Widget _buildMarkdown(Map<String, dynamic>? content, bool isDark) {
    if (content == null || !content.containsKey('markdown')) {
      return Text(
        'No content available for this step.',
        style: TextStyle(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
        ),
      );
    }

    return MarkdownBody(
      data: content['markdown'] as String,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        h2: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        ),
        h3: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        ),
        p: TextStyle(
          fontSize: 14,
          height: 1.6,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        ),
        strong: TextStyle(
          fontWeight: FontWeight.w700,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        ),
        listBullet: TextStyle(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        ),
        blockquoteDecoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.08),
          border: const Border(left: BorderSide(color: AppColors.accent, width: 3)),
        ),
        blockquotePadding: const EdgeInsets.all(AppSpacing.sm),
        code: TextStyle(
          backgroundColor: isDark ? AppColors.slate800 : AppColors.slate100,
          color: isDark ? AppColors.accentLight : AppColors.accentDark,
          fontSize: 13,
        ),
        codeblockDecoration: BoxDecoration(
          color: isDark ? AppColors.slate800 : AppColors.slate100,
          borderRadius: AppSpacing.borderRadiusSm,
        ),
        codeblockPadding: const EdgeInsets.all(AppSpacing.sm),
      ),
    );
  }
}
