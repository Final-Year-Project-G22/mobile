// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'finalize_upload_request.freezed.dart';
part 'finalize_upload_request.g.dart';

@Freezed()
abstract class FinalizeUploadRequest with _$FinalizeUploadRequest {
  const factory FinalizeUploadRequest({
    /// Hex encoded SHA-256 checksum
    required String checksumSha256,

    /// Uploaded object MIME type
    required String contentType,

    /// Client idempotency key for dedupe
    required String idempotencyKey,

    /// Uploaded object size in bytes
    required int sizeBytes,

    /// Uploaded object key
    required String storageKey,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Optional batch identifier
    String? batchId,

    /// Optional language hint (e.g. en, am)
    String? declaredLanguage,

    /// Optional original filename
    String? sourceFilename,
  }) = _FinalizeUploadRequest;

  factory FinalizeUploadRequest.fromJson(Map<String, Object?> json) =>
      _$FinalizeUploadRequestFromJson(json);
}
