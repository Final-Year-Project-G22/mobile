// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_upload_intent_response_body.freezed.dart';
part 'create_upload_intent_response_body.g.dart';

@Freezed()
abstract class CreateUploadIntentResponseBody with _$CreateUploadIntentResponseBody {
  const factory CreateUploadIntentResponseBody({
    /// Upload intent expiry timestamp
    required DateTime expiresAt,

    /// Resolved object key for upload
    required String key,

    /// HTTP method for upload
    required String method,

    /// Direct upload URL
    required String uploadUrl,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Headers required by storage provider
    Map<String, String>? headers,
  }) = _CreateUploadIntentResponseBody;

  factory CreateUploadIntentResponseBody.fromJson(Map<String, Object?> json) =>
      _$CreateUploadIntentResponseBodyFromJson(json);
}
