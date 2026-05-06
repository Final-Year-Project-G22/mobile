// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_step_dependency.freezed.dart';
part 'create_step_dependency.g.dart';

@Freezed()
abstract class CreateStepDependency with _$CreateStepDependency {
  const factory CreateStepDependency({
    /// Dependency type
    required String dependencyType,

    /// Required step ID
    required String requiredStepId,
  }) = _CreateStepDependency;

  factory CreateStepDependency.fromJson(Map<String, Object?> json) => _$CreateStepDependencyFromJson(json);
}
