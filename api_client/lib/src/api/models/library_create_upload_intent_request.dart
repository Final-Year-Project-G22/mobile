// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_create_upload_intent_request.freezed.dart';
part 'library_create_upload_intent_request.g.dart';

@Freezed()
abstract class LibraryCreateUploadIntentRequest
    with _$LibraryCreateUploadIntentRequest {
  const factory LibraryCreateUploadIntentRequest({
    /// MIME type
    required String contentType,

    /// Original filename
    required String fileName,

    /// File size in bytes
    required int fileSize,

    /// Language code
    required String language,

    /// Template title
    required String title,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Template description
    String? description,
  }) = _LibraryCreateUploadIntentRequest;

  factory LibraryCreateUploadIntentRequest.fromJson(
    Map<String, Object?> json,
  ) => _$LibraryCreateUploadIntentRequestFromJson(json);
}
