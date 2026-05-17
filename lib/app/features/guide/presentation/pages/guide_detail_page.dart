import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../constants/app_spacing.dart';
import '../../application/guide_detail_notifier.dart';
import '../../domain/entities/step_enums.dart';
import '../widgets/guide_progress_bar.dart';
import '../widgets/step_timeline_tile.dart';

class GuideDetailPage extends ConsumerStatefulWidget {
  const GuideDetailPage({required this.guideSlug, super.key});

  final String guideSlug;

  @override
  ConsumerState<GuideDetailPage> createState() => _GuideDetailPageState();
}

class _GuideDetailPageState extends ConsumerState<GuideDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(
        ref.read(guideDetailProvider.notifier).loadGuide(widget.guideSlug),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(guideDetailProvider);
    final guide = state.guide;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(guide?.name ?? l10n.guide),
      ),
      body: guide == null
          ? const Center(child: AdisuProgressIndicator())
          : Column(
              children: [
                GuideProgressBar(
                  completed: guide.progress.completedSteps,
                  total: guide.progress.totalSteps,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: AppSpacing.md),
                    itemCount: guide.steps.length,
                    itemBuilder: (_, index) {
                      final step = guide.steps[index];
                      return StepTimelineTile(
                        step: step,
                        index: index,
                        isLast: index == guide.steps.length - 1,
                        onTap: step.status == StepStatus.locked
                            ? null
                            : () {
                                unawaited(
                                  context.push(
                                    '/guides/${widget.guideSlug}/step/${step.slug}',
                                  ),
                                );
                              },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
