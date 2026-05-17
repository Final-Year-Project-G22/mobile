import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../../shared/widgets/status_badge.dart';
import '../../../../../shared/utils/html_utils.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final guideState = ref.read(guideDetailProvider);
      final step = guideState.guide?.steps.firstWhere(
        (s) => s.slug == widget.stepSlug,
      );
      if (step != null) {
        ref.read(stepDetailProvider.notifier).loadStepFromGuide(step);
      }
    });
  }

  Future<void> _startStep() async {
    await ref.read(stepDetailProvider.notifier).startStep();
    if (!mounted) return;
    ref
        .read(guideDetailProvider.notifier)
        .updateStepStatus(widget.stepSlug, StepStatus.inProgress);
  }

  Future<void> _completeAndReturn() async {
    final notifier = ref.read(stepDetailProvider.notifier);
    await notifier.startStep();
    await notifier.completeStep();
    if (!mounted) return;
    ref
        .read(guideDetailProvider.notifier)
        .updateStepStatus(widget.stepSlug, StepStatus.completed);
    Navigator.of(context).pop();
  }

  Future<void> _skipAndReturn() async {
    await ref.read(stepDetailProvider.notifier).skipStep();
    if (!mounted) return;
    ref
        .read(guideDetailProvider.notifier)
        .updateStepStatus(widget.stepSlug, StepStatus.skipped);
    Navigator.of(context).pop();
  }

  Future<void> _markIncompleteAndReturn() async {
    await ref.read(stepDetailProvider.notifier).markIncomplete();
    if (!mounted) return;
    ref
        .read(guideDetailProvider.notifier)
        .updateStepStatus(widget.stepSlug, StepStatus.inProgress);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stepDetailProvider);
    final step = state.step;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(step?.title ?? l10n.stepStatusLocked),
      ),
      body: step == null
          ? const Center(child: AdisuProgressIndicator())
          : Column(
              children: [
                // ── Step header ─────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    border: Border(
                      bottom: BorderSide(color: colorScheme.outlineVariant),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _statusBadge(step.status, l10n),
                          if (step.estimatedTime != null) ...[
                            AppSpacing.gapHorizontalSm,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHigh,
                                borderRadius: AppSpacing.borderRadiusFull,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 14,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  AppSpacing.gapHorizontalXxs,
                                  Text(
                                    l10n.stepEstimatedTime(
                                      '${step.estimatedTime}',
                                    ),
                                    style: textTheme.labelSmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
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
                          stripHtml(step.description!),
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // ── Markdown content ────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: _buildMarkdown(step.detailedContent, l10n),
                  ),
                ),

                // ── Action bar ──────────────────────────────────────
                StepActionBar(
                  status: step.status,
                  isOptional: step.isOptional,
                  isBookmarked: state.isBookmarked,
                  onStart: _startStep,
                  onComplete: _completeAndReturn,
                  onSkip: _skipAndReturn,
                  onMarkIncomplete: _markIncompleteAndReturn,
                  onToggleBookmark: () {
                    unawaited(
                      ref.read(stepDetailProvider.notifier).toggleBookmark(),
                    );
                  },
                ),
              ],
            ),
    );
  }

  Widget _statusBadge(StepStatus status, AppLocalizations l10n) {
    final statusType = switch (status) {
      StepStatus.completed => StatusType.completed,
      StepStatus.inProgress => StatusType.inProgress,
      StepStatus.skipped => StatusType.inProgress,
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

  Widget _buildMarkdown(
    Map<String, dynamic>? content,
    AppLocalizations l10n,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final markdown = content?['markdown'] as String?;

    if (markdown == null || markdown.isEmpty) {
      final step = ref.read(stepDetailProvider).step;
      final desc = step?.description;
      if (desc != null && desc.isNotEmpty) {
        return MarkdownBody(
          data: stripHtml(desc),
          selectable: true,
          styleSheet: _markdownStyle(colorScheme, textTheme),
        );
      }
      return Text(
        l10n.stepNoContent,
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      );
    }

    return MarkdownBody(
      data: markdown,
      selectable: true,
      styleSheet: _markdownStyle(colorScheme, textTheme),
    );
  }

  MarkdownStyleSheet _markdownStyle(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return MarkdownStyleSheet(
      h2: textTheme.titleMedium?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w700,
      ),
      h3: textTheme.titleSmall?.copyWith(
        color: colorScheme.onSurface,
      ),
      p: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        height: 1.6,
      ),
      strong: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w700,
      ),
      listBullet: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
      blockquoteDecoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withValues(alpha: 0.3),
        border: Border(
          left: BorderSide(color: colorScheme.secondary, width: 3),
        ),
      ),
      blockquotePadding: const EdgeInsets.all(AppSpacing.sm),
      code: textTheme.bodySmall?.copyWith(
        backgroundColor: colorScheme.surfaceContainerHigh,
        color: colorScheme.primary,
      ),
      codeblockDecoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      codeblockPadding: const EdgeInsets.all(AppSpacing.sm),
    );
  }
}
