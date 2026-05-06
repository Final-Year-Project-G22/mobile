// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_post_response_body.freezed.dart';
part 'report_post_response_body.g.dart';

@Freezed()
abstract class ReportPostResponseBody with _$ReportPostResponseBody {
  const factory ReportPostResponseBody({
    /// Report ID
    required String reportId,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ReportPostResponseBody;

  factory ReportPostResponseBody.fromJson(Map<String, Object?> json) => _$ReportPostResponseBodyFromJson(json);
}
