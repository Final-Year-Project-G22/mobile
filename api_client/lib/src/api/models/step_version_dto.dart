// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'step_version_dto.freezed.dart';
part 'step_version_dto.g.dart';

@Freezed()
abstract class StepVersionDto with _$StepVersionDto {
  const factory StepVersionDto({
    /// When this version was created
    required String? createdAt,

    /// When this version became active
    required DateTime effectiveDate,

    /// Version record ID
    required String id,

    /// Step ID
    required String stepId,

    /// Version number
    required int version,
  }) = _StepVersionDto;

  factory StepVersionDto.fromJson(Map<String, Object?> json) => _$StepVersionDtoFromJson(json);
}
