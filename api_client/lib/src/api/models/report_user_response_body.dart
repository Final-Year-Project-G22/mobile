// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_user_response_body.freezed.dart';
part 'report_user_response_body.g.dart';

@Freezed()
abstract class ReportUserResponseBody with _$ReportUserResponseBody {
  const factory ReportUserResponseBody({
    /// Report ID
    required String reportId,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ReportUserResponseBody;

  factory ReportUserResponseBody.fromJson(Map<String, Object?> json) => _$ReportUserResponseBodyFromJson(json);
}
