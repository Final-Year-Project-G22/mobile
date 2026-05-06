// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_reported_content_response_body.freezed.dart';
part 'delete_reported_content_response_body.g.dart';

@Freezed()
abstract class DeleteReportedContentResponseBody with _$DeleteReportedContentResponseBody {
  const factory DeleteReportedContentResponseBody({
    /// Message
    required String message,

    /// Success
    required bool success,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _DeleteReportedContentResponseBody;

  factory DeleteReportedContentResponseBody.fromJson(Map<String, Object?> json) =>
      _$DeleteReportedContentResponseBodyFromJson(json);
}
