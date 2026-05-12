// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_step_dependency_response_body.freezed.dart';
part 'add_step_dependency_response_body.g.dart';

@Freezed()
abstract class AddStepDependencyResponseBody
    with _$AddStepDependencyResponseBody {
  const factory AddStepDependencyResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AddStepDependencyResponseBody;

  factory AddStepDependencyResponseBody.fromJson(Map<String, Object?> json) =>
      _$AddStepDependencyResponseBodyFromJson(json);
}
