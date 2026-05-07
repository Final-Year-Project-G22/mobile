import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/guide_providers.dart';
import '../domain/entities/guide_step.dart';
import '../domain/entities/step_enums.dart';

part 'step_detail_notifier.g.dart';

class StepDetailState {
  const StepDetailState({
    this.step,
    this.isLoading = false,
    this.actionInProgress = false,
    this.error,
  });

  final GuideStep? step;
  final bool isLoading;
  final bool actionInProgress;
  final String? error;

  StepDetailState copyWith({
    GuideStep? step,
    bool? isLoading,
    bool? actionInProgress,
    String? error,
  }) {
    return StepDetailState(
      step: step ?? this.step,
      isLoading: isLoading ?? this.isLoading,
      actionInProgress: actionInProgress ?? this.actionInProgress,
      error: error ?? this.error,
    );
  }
}

@riverpod
class StepDetailNotifier extends _$StepDetailNotifier {
  @override
  StepDetailState build() => const StepDetailState();

  void loadStepFromGuide(GuideStep step) {
    state = state.copyWith(step: step);
  }

  Future<void> startStep() async {
    final s = state.step;
    if (s == null) return;
    state = state.copyWith(actionInProgress: true);
    final repo = ref.read(guideRepositoryProvider);
    final result = await repo.startStep(s.id);
    result.fold(
      (f) => state = state.copyWith(actionInProgress: false, error: 'Failed to start step'),
      (_) => _updateStatus(StepStatus.inProgress),
    );
  }

  Future<void> completeStep() async {
    final s = state.step;
    if (s == null) return;
    state = state.copyWith(actionInProgress: true);
    final repo = ref.read(guideRepositoryProvider);
    final result = await repo.completeStep(s.id);
    result.fold(
      (f) => state = state.copyWith(actionInProgress: false, error: 'Failed to complete step'),
      (_) => _updateStatus(StepStatus.completed),
    );
  }

  Future<void> skipStep() async {
    final s = state.step;
    if (s == null || !s.isOptional) return;
    state = state.copyWith(actionInProgress: true);
    final repo = ref.read(guideRepositoryProvider);
    final result = await repo.skipStep(s.id);
    result.fold(
      (f) => state = state.copyWith(actionInProgress: false, error: 'Failed to skip step'),
      (_) => _updateStatus(StepStatus.skipped),
    );
  }

  Future<void> markIncomplete() async {
    final s = state.step;
    if (s == null) return;
    state = state.copyWith(actionInProgress: true);
    final repo = ref.read(guideRepositoryProvider);
    final result = await repo.markStepIncomplete(s.id);
    result.fold(
      (f) => state = state.copyWith(actionInProgress: false, error: 'Failed to mark incomplete'),
      (_) => _updateStatus(StepStatus.inProgress),
    );
  }

  Future<void> toggleBookmark() async {
    final s = state.step;
    if (s == null) return;
    final repo = ref.read(guideRepositoryProvider);
    // Track bookmark state to know whether to add or remove
    await repo.addBookmark(s.id);
  }

  void _updateStatus(StepStatus newStatus) {
    final s = state.step;
    if (s == null) return;
    state = state.copyWith(
      actionInProgress: false,
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
