// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_post_report_status_request.freezed.dart';
part 'update_post_report_status_request.g.dart';

@Freezed()
abstract class UpdatePostReportStatusRequest with _$UpdatePostReportStatusRequest {
  const factory UpdatePostReportStatusRequest({
    /// Status: pending, under_review, resolved, dismissed
    required String status,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Admin note
    String? adminNote,
  }) = _UpdatePostReportStatusRequest;

  factory UpdatePostReportStatusRequest.fromJson(Map<String, Object?> json) =>
      _$UpdatePostReportStatusRequestFromJson(json);
}
