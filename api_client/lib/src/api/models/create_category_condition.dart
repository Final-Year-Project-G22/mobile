// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_category_condition.freezed.dart';
part 'create_category_condition.g.dart';

@Freezed()
abstract class CreateCategoryCondition with _$CreateCategoryCondition {
  const factory CreateCategoryCondition({
    /// Condition type
    required String conditionType,

    /// Condition value
    required dynamic conditionValue,

    /// Whether to invert the condition
    required bool isInverse,
    @JsonKey(name: 'operator') required String operatorField,
  }) = _CreateCategoryCondition;

  factory CreateCategoryCondition.fromJson(Map<String, Object?> json) =>
      _$CreateCategoryConditionFromJson(json);
}
