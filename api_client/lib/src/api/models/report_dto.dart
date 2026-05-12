// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_dto.freezed.dart';
part 'report_dto.g.dart';

@Freezed()
abstract class ReportDto with _$ReportDto {
  const factory ReportDto({
    /// Created timestamp
    required String createdAt,

    /// Report ID
    required String id,

    /// Report reason
    required String reason,

    /// Reporter first name
    required String reporterFirstName,

    /// Reporter account ID
    required String reporterId,

    /// Reporter last name
    required String reporterLastName,

    /// Report status
    required String status,

    /// Admin note
    String? adminNote,

    /// Post ID
    String? postId,

    /// Reported account ID
    String? reportedAccountId,

    /// Resolved timestamp
    String? resolvedAt,

    /// Resolved by account ID
    String? resolvedBy,

    /// Thread ID
    String? threadId,
  }) = _ReportDto;

  factory ReportDto.fromJson(Map<String, Object?> json) =>
      _$ReportDtoFromJson(json);
}
