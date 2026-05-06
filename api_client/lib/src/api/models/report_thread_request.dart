// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_thread_request.freezed.dart';
part 'report_thread_request.g.dart';

@Freezed()
abstract class ReportThreadRequest with _$ReportThreadRequest {
  const factory ReportThreadRequest({
    /// Report reason
    required String reason,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ReportThreadRequest;

  factory ReportThreadRequest.fromJson(Map<String, Object?> json) => _$ReportThreadRequestFromJson(json);
}
