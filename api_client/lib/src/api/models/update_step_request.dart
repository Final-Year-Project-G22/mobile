// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_step_request.freezed.dart';
part 'update_step_request.g.dart';

@Freezed()
abstract class UpdateStepRequest with _$UpdateStepRequest {
  const factory UpdateStepRequest({
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

    /// Whether step can be skipped
    bool? isOptional,

    /// Step slug
    String? slug,

    /// Display order
    int? sortOrder,

    /// Step type
    String? stepType,

    /// Localized translations
    List<dynamic>? translations,
  }) = _UpdateStepRequest;

  factory UpdateStepRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateStepRequestFromJson(json);
}
