import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/entities/guide_detail.dart';
import '../domain/entities/guide_step.dart';
import '../domain/entities/step_enums.dart';
import '../infrastructure/guide_dummy_data.dart';

part 'guide_detail_notifier.g.dart';

class GuideDetailState {
  const GuideDetailState({
    this.guide,
    this.isLoading = false,
  });

  final GuideDetail? guide;
  final bool isLoading;

  GuideDetailState copyWith({GuideDetail? guide, bool? isLoading}) {
    return GuideDetailState(
      guide: guide ?? this.guide,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

@riverpod
class GuideDetailNotifier extends _$GuideDetailNotifier {
  @override
  GuideDetailState build() => const GuideDetailState();

  void loadGuide(String slug) {
    final guide = GuideDummyData.getGuideDetail(slug);
    state = state.copyWith(guide: guide);
  }

  void updateStepStatus(String stepSlug, StepStatus newStatus) {
    final guide = state.guide;
    if (guide == null) return;

    final newSteps = <GuideStep>[];
    int? completedIdx;

    for (var i = 0; i < guide.steps.length; i++) {
      final s = guide.steps[i];
      if (s.slug == stepSlug) {
        completedIdx = i;
        newSteps.add(
          GuideStep(
            id: s.id,
            slug: s.slug,
            title: s.title,
            stepType: s.stepType,
            sortOrder: s.sortOrder,
            status: newStatus,
            description: s.description,
            isOptional: s.isOptional,
            estimatedTime: s.estimatedTime,
            detailedContent: s.detailedContent,
          ),
        );
      } else {
        newSteps.add(s);
      }
    }

    if (completedIdx != null && newStatus == StepStatus.completed) {
      final nextIdx = completedIdx + 1;
      if (nextIdx < newSteps.length && newSteps[nextIdx].status == StepStatus.locked) {
        final s = guide.steps[nextIdx];
        newSteps[nextIdx] = GuideStep(
          id: s.id,
          slug: s.slug,
          title: s.title,
          stepType: s.stepType,
          sortOrder: s.sortOrder,
          status: StepStatus.inProgress,
          description: s.description,
          isOptional: s.isOptional,
          estimatedTime: s.estimatedTime,
          detailedContent: s.detailedContent,
        );
      }
    }

    if (newStatus == StepStatus.inProgress) {
      for (var i = 0; i < newSteps.length; i++) {
        if (i > 0 &&
            newSteps[i].status == StepStatus.inProgress &&
            newSteps[i - 1].status != StepStatus.completed &&
            newSteps[i - 1].status != StepStatus.skipped) {
          break;
        }
      }
    }

    final completed = newSteps.where((s) => s.status == StepStatus.completed).length;
    final skipped = newSteps.where((s) => s.status == StepStatus.skipped).length;
    final inProgress = newSteps.where((s) => s.status == StepStatus.inProgress).length;

    state = state.copyWith(
      guide: GuideDetail(
        id: guide.id,
        slug: guide.slug,
        name: guide.name,
        description: guide.description,
        steps: newSteps,
        progress: GuideProgressSummary(
          totalSteps: guide.progress.totalSteps,
          completedSteps: completed,
          skippedSteps: skipped,
          inProgressSteps: inProgress,
        ),
      ),
    );
  }

  void refresh(String slug) {
    loadGuide(slug);
  }
}
