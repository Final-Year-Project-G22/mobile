// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_document_response_body.freezed.dart';
part 'delete_document_response_body.g.dart';

@Freezed()
abstract class DeleteDocumentResponseBody with _$DeleteDocumentResponseBody {
  const factory DeleteDocumentResponseBody({
    /// Whether deletion succeeded
    required bool success,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _DeleteDocumentResponseBody;

  factory DeleteDocumentResponseBody.fromJson(Map<String, Object?> json) => _$DeleteDocumentResponseBodyFromJson(json);
}
