// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_step_translation_dto.freezed.dart';
part 'admin_step_translation_dto.g.dart';

@Freezed()
abstract class AdminStepTranslationDto with _$AdminStepTranslationDto {
  const factory AdminStepTranslationDto({
    required String language,
    required String title,
    String? description,
    dynamic detailedContent,
    dynamic requiredDocuments,
  }) = _AdminStepTranslationDto;

  factory AdminStepTranslationDto.fromJson(Map<String, Object?> json) =>
      _$AdminStepTranslationDtoFromJson(json);
}
