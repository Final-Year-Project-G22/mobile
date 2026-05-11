// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'stream_status_by_document_input_body.freezed.dart';
part 'stream_status_by_document_input_body.g.dart';

@Freezed()
abstract class StreamStatusByDocumentInputBody
    with _$StreamStatusByDocumentInputBody {
  const factory StreamStatusByDocumentInputBody({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _StreamStatusByDocumentInputBody;

  factory StreamStatusByDocumentInputBody.fromJson(Map<String, Object?> json) =>
      _$StreamStatusByDocumentInputBodyFromJson(json);
}
