// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'content_dto.dart';
import 'report_dto.dart';

part 'get_thread_report_response_body.freezed.dart';
part 'get_thread_report_response_body.g.dart';

@Freezed()
abstract class GetThreadReportResponseBody with _$GetThreadReportResponseBody {
  const factory GetThreadReportResponseBody({
    /// Report details
    required ReportDto report,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Thread content
    ContentDto? content,
  }) = _GetThreadReportResponseBody;

  factory GetThreadReportResponseBody.fromJson(Map<String, Object?> json) =>
      _$GetThreadReportResponseBodyFromJson(json);
}
