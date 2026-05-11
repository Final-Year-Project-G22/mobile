// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'citation_dto.freezed.dart';
part 'citation_dto.g.dart';

@Freezed()
abstract class CitationDto with _$CitationDto {
  const factory CitationDto({
    required String chunkId,
    required String documentId,
    required double score,
    required String sourceType,
    String? title,
  }) = _CitationDto;

  factory CitationDto.fromJson(Map<String, Object?> json) => _$CitationDtoFromJson(json);
}
