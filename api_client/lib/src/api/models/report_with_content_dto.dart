// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'content_dto.dart';
import 'report_dto.dart';

part 'report_with_content_dto.freezed.dart';
part 'report_with_content_dto.g.dart';

@Freezed()
abstract class ReportWithContentDto with _$ReportWithContentDto {
  const factory ReportWithContentDto({
    /// Report details
    required ReportDto report,

    /// Reported content details
    ContentDto? content,
  }) = _ReportWithContentDto;

  factory ReportWithContentDto.fromJson(Map<String, Object?> json) => _$ReportWithContentDtoFromJson(json);
}
