import 'step_enums.dart';

class GuideStep {
  const GuideStep({
    required this.id,
    required this.slug,
    required this.title,
    required this.stepType,
    required this.sortOrder,
    required this.status,
    this.description,
    this.isOptional = false,
    this.estimatedTime,
    this.detailedContent,
  });

  final String id;
  final String slug;
  final String title;
  final StepType stepType;
  final int sortOrder;
  final StepStatus status;
  final String? description;
  final bool isOptional;
  final int? estimatedTime;
  final Map<String, dynamic>? detailedContent;
}
