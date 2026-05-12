// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'content_dto.dart';
import 'report_dto.dart';

part 'get_user_report_response_body.freezed.dart';
part 'get_user_report_response_body.g.dart';

@Freezed()
abstract class GetUserReportResponseBody with _$GetUserReportResponseBody {
  const factory GetUserReportResponseBody({
    /// Report details
    required ReportDto report,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// User content
    ContentDto? content,
  }) = _GetUserReportResponseBody;

  factory GetUserReportResponseBody.fromJson(Map<String, Object?> json) => _$GetUserReportResponseBodyFromJson(json);
}
