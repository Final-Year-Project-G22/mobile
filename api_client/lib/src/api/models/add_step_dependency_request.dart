// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_step_dependency_request.freezed.dart';
part 'add_step_dependency_request.g.dart';

@Freezed()
abstract class AddStepDependencyRequest with _$AddStepDependencyRequest {
  const factory AddStepDependencyRequest({
    /// Dependency type
    required String dependencyType,

    /// Required step ID
    required String requiredStepId,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AddStepDependencyRequest;

  factory AddStepDependencyRequest.fromJson(Map<String, Object?> json) =>
      _$AddStepDependencyRequestFromJson(json);
}
