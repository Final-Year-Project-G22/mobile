import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/entities/guide_step.dart';
import '../domain/entities/step_enums.dart';
import '../infrastructure/guide_dummy_data.dart';

part 'step_detail_notifier.g.dart';

class StepDetailState {
  const StepDetailState({
    this.step,
    this.isLoading = false,
    this.actionInProgress = false,
  });

  final GuideStep? step;
  final bool isLoading;
  final bool actionInProgress;

  StepDetailState copyWith({
    GuideStep? step,
    bool? isLoading,
    bool? actionInProgress,
  }) {
    return StepDetailState(
      step: step ?? this.step,
      isLoading: isLoading ?? this.isLoading,
      actionInProgress: actionInProgress ?? this.actionInProgress,
    );
  }
}

@riverpod
class StepDetailNotifier extends _$StepDetailNotifier {
  @override
  StepDetailState build() => const StepDetailState();

  void loadStep(String guideSlug, String stepSlug) {
    final step = GuideDummyData.getStep(guideSlug, stepSlug);
    state = state.copyWith(step: step);
  }

  void startStep() {
    _updateStatus(StepStatus.inProgress);
  }

  void completeStep() {
    _updateStatus(StepStatus.completed);
  }

  void skipStep() {
    _updateStatus(StepStatus.skipped);
  }

  void markIncomplete() {
    _updateStatus(StepStatus.inProgress);
  }

  void _updateStatus(StepStatus newStatus) {
    final s = state.step;
    if (s == null) return;
    state = state.copyWith(
      step: GuideStep(
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
  }
}
