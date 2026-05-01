// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_post_request.freezed.dart';
part 'report_post_request.g.dart';

@Freezed()
abstract class ReportPostRequest with _$ReportPostRequest {
  const factory ReportPostRequest({
    /// Report reason
    required String reason,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ReportPostRequest;

  factory ReportPostRequest.fromJson(Map<String, Object?> json) =>
      _$ReportPostRequestFromJson(json);
}
