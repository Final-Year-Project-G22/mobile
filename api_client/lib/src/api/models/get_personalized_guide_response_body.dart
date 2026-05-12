// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'guide_progress_summary_dto.dart';

part 'get_personalized_guide_response_body.freezed.dart';
part 'get_personalized_guide_response_body.g.dart';

@Freezed()
abstract class GetPersonalizedGuideResponseBody
    with _$GetPersonalizedGuideResponseBody {
  const factory GetPersonalizedGuideResponseBody({
    /// Guide ID
    required String id,

    /// Localized guide name
    required String name,

    /// Guide slug
    required String slug,

    /// Guide steps with user progress
    required List<dynamic>? steps,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Localized description
    String? description,

    /// User progress summary
    GuideProgressSummaryDto? progress,
  }) = _GetPersonalizedGuideResponseBody;

  factory GetPersonalizedGuideResponseBody.fromJson(
    Map<String, Object?> json,
  ) => _$GetPersonalizedGuideResponseBodyFromJson(json);
}
