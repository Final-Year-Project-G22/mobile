// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_create_upload_intent_output_body.freezed.dart';
part 'library_create_upload_intent_output_body.g.dart';

@Freezed()
abstract class LibraryCreateUploadIntentOutputBody
    with _$LibraryCreateUploadIntentOutputBody {
  const factory LibraryCreateUploadIntentOutputBody({
    /// Upload URL expiry time
    required String expiresAt,

    /// Storage key for the file
    required String fileKey,

    /// HTTP method for upload
    required String method,

    /// Direct upload URL
    required String uploadUrl,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Required upload headers
    Map<String, String>? headers,
  }) = _LibraryCreateUploadIntentOutputBody;

  factory LibraryCreateUploadIntentOutputBody.fromJson(
    Map<String, Object?> json,
  ) => _$LibraryCreateUploadIntentOutputBodyFromJson(json);
}
