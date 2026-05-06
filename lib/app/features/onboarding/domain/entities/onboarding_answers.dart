class OnboardingAnswers {
  const OnboardingAnswers({
    this.region,
    this.lifecycleStage,
    this.industry,
    this.legalStructure,
    this.taxStatus,
    this.operations = const {},
    this.demographics = const {},
  });

  final String? region;
  final String? lifecycleStage;
  final String? industry;
  final String? legalStructure;
  final String? taxStatus;
  final Set<String> operations;
  final Set<String> demographics;

  OnboardingAnswers copyWith({
    String? region,
    String? lifecycleStage,
    String? industry,
    String? legalStructure,
    String? taxStatus,
    Set<String>? operations,
    Set<String>? demographics,
  }) {
    return OnboardingAnswers(
      region: region ?? this.region,
      lifecycleStage: lifecycleStage ?? this.lifecycleStage,
      industry: industry ?? this.industry,
      legalStructure: legalStructure ?? this.legalStructure,
      taxStatus: taxStatus ?? this.taxStatus,
      operations: operations ?? this.operations,
      demographics: demographics ?? this.demographics,
    );
  }
}
