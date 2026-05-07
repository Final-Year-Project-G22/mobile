import 'guide_step.dart';

class GuideDetail {
  const GuideDetail({
    required this.id,
    required this.slug,
    required this.name,
    required this.steps,
    required this.progress,
    this.description,
  });

  final String id;
  final String slug;
  final String name;
  final String? description;
  final List<GuideStep> steps;
  final GuideProgressSummary progress;
}

class GuideProgressSummary {
  const GuideProgressSummary({
    required this.totalSteps,
    required this.completedSteps,
    required this.skippedSteps,
    required this.inProgressSteps,
  });

  final int totalSteps;
  final int completedSteps;
  final int skippedSteps;
  final int inProgressSteps;

  double get percent => totalSteps > 0 ? completedSteps / totalSteps : 0;
  int get lockedSteps => totalSteps - completedSteps - skippedSteps - inProgressSteps;
}
