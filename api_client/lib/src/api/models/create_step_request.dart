// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_step_request.freezed.dart';
part 'create_step_request.g.dart';

@Freezed()
abstract class CreateStepRequest with _$CreateStepRequest {
  const factory CreateStepRequest({
    /// Parent guide ID
    required String guideId,

    /// Whether step can be skipped
    required bool isOptional,

    /// Step slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// Step type
    required String stepType,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Visibility conditions
    List<dynamic>? conditions,

    /// Step dependencies
    List<dynamic>? dependencies,

    /// Difficulty level (1-5)
    int? difficultyLevel,

    /// When step becomes active
    DateTime? effectiveDate,

    /// Estimated time in minutes
    int? estimatedTime,

    /// When step expires
    DateTime? expiryDate,

    /// Estimated fee
    int? feeEstimate,

    /// Localized translations
    List<dynamic>? translations,
  }) = _CreateStepRequest;

  factory CreateStepRequest.fromJson(Map<String, Object?> json) =>
      _$CreateStepRequestFromJson(json);
}
