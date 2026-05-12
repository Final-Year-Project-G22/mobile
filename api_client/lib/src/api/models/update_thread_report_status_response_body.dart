// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'report_dto.dart';

part 'update_thread_report_status_response_body.freezed.dart';
part 'update_thread_report_status_response_body.g.dart';

@Freezed()
abstract class UpdateThreadReportStatusResponseBody with _$UpdateThreadReportStatusResponseBody {
  const factory UpdateThreadReportStatusResponseBody({
    /// Updated report
    required ReportDto report,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateThreadReportStatusResponseBody;

  factory UpdateThreadReportStatusResponseBody.fromJson(Map<String, Object?> json) =>
      _$UpdateThreadReportStatusResponseBodyFromJson(json);
}
