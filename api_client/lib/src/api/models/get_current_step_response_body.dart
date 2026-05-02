// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_current_step_response_body.freezed.dart';
part 'get_current_step_response_body.g.dart';

@Freezed()
abstract class GetCurrentStepResponseBody with _$GetCurrentStepResponseBody {
  const factory GetCurrentStepResponseBody({
    /// Step ID
    required String id,

    /// Whether step can be skipped
    required bool isOptional,

    /// Step slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// Step type
    required String stepType,

    /// Localized step title
    required String title,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Localized description
    String? description,

    /// Estimated time in minutes
    int? estimatedTime,
  }) = _GetCurrentStepResponseBody;

  factory GetCurrentStepResponseBody.fromJson(Map<String, Object?> json) =>
      _$GetCurrentStepResponseBodyFromJson(json);
}
