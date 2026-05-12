class CompletionStats {
  const CompletionStats({
    required this.completedGuides,
    required this.inProgressGuides,
    required this.totalStepsCompleted,
    required this.totalStepsAll,
    this.period,
  });

  final int completedGuides;
  final int inProgressGuides;
  final int totalStepsCompleted;
  final int totalStepsAll;
  final String? period;

  double get percent =>
      totalStepsAll > 0 ? totalStepsCompleted / totalStepsAll : 0.0;
}
