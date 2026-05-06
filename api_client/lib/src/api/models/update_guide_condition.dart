// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_guide_condition.freezed.dart';
part 'update_guide_condition.g.dart';

@Freezed()
abstract class UpdateGuideCondition with _$UpdateGuideCondition {
  const factory UpdateGuideCondition({
    /// Condition type
    required String conditionType,

    /// Condition value
    required dynamic conditionValue,

    /// Whether to invert the condition
    required bool isInverse,
    @JsonKey(name: 'operator') required String operatorField,
  }) = _UpdateGuideCondition;

  factory UpdateGuideCondition.fromJson(Map<String, Object?> json) => _$UpdateGuideConditionFromJson(json);
}
