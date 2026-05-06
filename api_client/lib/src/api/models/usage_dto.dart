// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'usage_dto.freezed.dart';
part 'usage_dto.g.dart';

@Freezed()
abstract class UsageDto with _$UsageDto {
  const factory UsageDto({required int completionTokens, required int promptTokens, required int totalTokens}) =
      _UsageDto;

  factory UsageDto.fromJson(Map<String, Object?> json) => _$UsageDtoFromJson(json);
}
