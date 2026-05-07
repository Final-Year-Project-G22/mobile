enum StepType { informational, actionRequired, documentSubmission, verification }

enum StepStatus {
  locked,
  inProgress,
  completed,
  skipped
  ;

  bool get isActionable => this == inProgress;
  bool get isDone => this == completed || this == skipped;
}
