// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_step_condition_request.freezed.dart';
part 'add_step_condition_request.g.dart';

@Freezed()
abstract class AddStepConditionRequest with _$AddStepConditionRequest {
  const factory AddStepConditionRequest({
    /// Condition type
    required String conditionType,

    /// Condition value
    required dynamic conditionValue,

    /// Whether to invert the condition
    required bool isInverse,
    @JsonKey(name: 'operator') required String operatorField,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AddStepConditionRequest;

  factory AddStepConditionRequest.fromJson(Map<String, Object?> json) => _$AddStepConditionRequestFromJson(json);
}
