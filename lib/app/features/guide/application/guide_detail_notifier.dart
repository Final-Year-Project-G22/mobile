import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/guide_providers.dart';
import '../domain/entities/guide_detail.dart';
import '../domain/entities/guide_step.dart';
import '../domain/entities/step_enums.dart';
import '../domain/failures/guide_failures.dart';

part 'guide_detail_notifier.g.dart';

class GuideDetailState {
  const GuideDetailState({
    this.guide,
    this.isLoading = false,
    this.error,
  });

  final GuideDetail? guide;
  final bool isLoading;
  final String? error;

  GuideDetailState copyWith({
    GuideDetail? guide,
    bool? isLoading,
    String? error,
  }) {
    return GuideDetailState(
      guide: guide ?? this.guide,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

@riverpod
class GuideDetailNotifier extends _$GuideDetailNotifier {
  @override
  GuideDetailState build() => const GuideDetailState();

  Future<void> loadGuide(String slug) async {
    state = state.copyWith(isLoading: true);
    final repo = ref.read(guideRepositoryProvider);
    final result = await repo.getPersonalizedGuide(slug, null);
    result.fold(
      (f) {
        final message = f.map(
          serverError: (e) => e.message ?? 'Server error',
          networkError: (_) => 'Network error',
          notFound: (_) => 'Guide not found',
          unauthorized: (_) => 'Please log in again',
          conflict: (c) => c.message ?? 'Conflict',
        );
        state = state.copyWith(isLoading: false, error: message);
      },
      (guide) => state = state.copyWith(guide: guide, isLoading: false),
    );
  }

  void updateStepStatus(String stepSlug, StepStatus newStatus) {
    final guide = state.guide;
    if (guide == null) return;

    final newSteps = guide.steps.map((s) {
      if (s.slug == stepSlug) {
        return GuideStep(
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
        );
      }
      return s;
    }).toList();

    if (newStatus == StepStatus.completed) {
      final idx = newSteps.indexWhere((s) => s.slug == stepSlug);
      final nextIdx = idx + 1;
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

  Future<void> refresh(String slug) async {
    await loadGuide(slug);
  }
}
