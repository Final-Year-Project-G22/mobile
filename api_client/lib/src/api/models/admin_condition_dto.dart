// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_condition_dto.freezed.dart';
part 'admin_condition_dto.g.dart';

@Freezed()
abstract class AdminConditionDto with _$AdminConditionDto {
  const factory AdminConditionDto({
    required String conditionType,
    required dynamic conditionValue,
    required String id,
    required bool isInverse,
    @JsonKey(name: 'operator') required String operatorField,
  }) = _AdminConditionDto;

  factory AdminConditionDto.fromJson(Map<String, Object?> json) =>
      _$AdminConditionDtoFromJson(json);
}
