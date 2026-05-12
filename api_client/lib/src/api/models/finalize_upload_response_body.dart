// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'finalize_upload_response_body.freezed.dart';
part 'finalize_upload_response_body.g.dart';

@Freezed()
abstract class FinalizeUploadResponseBody with _$FinalizeUploadResponseBody {
  const factory FinalizeUploadResponseBody({
    /// Alias of ingestion document identifier
    required String documentId,

    /// Outbox event identifier
    required String eventId,

    /// Ingestion document identifier
    required String ingestionId,

    /// Initial ingestion state
    required String state,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _FinalizeUploadResponseBody;

  factory FinalizeUploadResponseBody.fromJson(Map<String, Object?> json) => _$FinalizeUploadResponseBodyFromJson(json);
}
