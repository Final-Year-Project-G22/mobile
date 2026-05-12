class GuideWithProgress {
  const GuideWithProgress({
    required this.id,
    required this.slug,
    required this.name,
    required this.completedSteps,
    required this.totalSteps,
    this.icon,
  });

  final String id;
  final String slug;
  final String name;
  final int completedSteps;
  final int totalSteps;
  final String? icon;

  double get percent => totalSteps > 0 ? completedSteps / totalSteps : 0.0;
}
