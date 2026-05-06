// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_upload_intent_request.freezed.dart';
part 'create_upload_intent_request.g.dart';

@Freezed()
abstract class CreateUploadIntentRequest with _$CreateUploadIntentRequest {
  const factory CreateUploadIntentRequest({
    /// Expected MIME content type
    required String contentType,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Optional client batch identifier
    String? batchId,

    /// Optional upload intent expiration in seconds
    int? expiresInSec,

    /// Optional metadata sent as upload headers
    Map<String, String>? metadata,

    /// Optional object key. If omitted, server generates one
    String? storageKey,
  }) = _CreateUploadIntentRequest;

  factory CreateUploadIntentRequest.fromJson(Map<String, Object?> json) => _$CreateUploadIntentRequestFromJson(json);
}
