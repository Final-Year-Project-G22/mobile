// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_translation_dto.freezed.dart';
part 'admin_translation_dto.g.dart';

@Freezed()
abstract class AdminTranslationDto with _$AdminTranslationDto {
  const factory AdminTranslationDto({required String language, required String name, String? description}) =
      _AdminTranslationDto;

  factory AdminTranslationDto.fromJson(Map<String, Object?> json) => _$AdminTranslationDtoFromJson(json);
}
