// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'report_dto.dart';

part 'update_user_report_status_response_body.freezed.dart';
part 'update_user_report_status_response_body.g.dart';

@Freezed()
abstract class UpdateUserReportStatusResponseBody
    with _$UpdateUserReportStatusResponseBody {
  const factory UpdateUserReportStatusResponseBody({
    /// Updated report
    required ReportDto report,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateUserReportStatusResponseBody;

  factory UpdateUserReportStatusResponseBody.fromJson(
    Map<String, Object?> json,
  ) => _$UpdateUserReportStatusResponseBodyFromJson(json);
}
