// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'preview_template_response_body.freezed.dart';
part 'preview_template_response_body.g.dart';

@Freezed()
abstract class PreviewTemplateResponseBody with _$PreviewTemplateResponseBody {
  const factory PreviewTemplateResponseBody({
    /// MIME type
    required String contentType,

    /// Expiry time
    required String expiresAt,

    /// Suggested filename
    required String filename,

    /// Temporary preview URL
    required String presignedUrl,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _PreviewTemplateResponseBody;

  factory PreviewTemplateResponseBody.fromJson(Map<String, Object?> json) =>
      _$PreviewTemplateResponseBodyFromJson(json);
}
