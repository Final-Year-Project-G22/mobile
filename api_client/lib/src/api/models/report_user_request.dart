// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_user_request.freezed.dart';
part 'report_user_request.g.dart';

@Freezed()
abstract class ReportUserRequest with _$ReportUserRequest {
  const factory ReportUserRequest({
    /// Report reason
    required String reason,

    /// Reported account ID
    required String reportedAccountId,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ReportUserRequest;

  factory ReportUserRequest.fromJson(Map<String, Object?> json) => _$ReportUserRequestFromJson(json);
}
