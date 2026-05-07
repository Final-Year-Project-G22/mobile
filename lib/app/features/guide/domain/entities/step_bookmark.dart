class StepBookmark {
  const StepBookmark({
    required this.id,
    required this.stepId,
    required this.stepTitle,
    required this.guideName,
    required this.createdAt,
    this.note,
  });

  final String id;
  final String stepId;
  final String stepTitle;
  final String guideName;
  final String? note;
  final String createdAt;
}
