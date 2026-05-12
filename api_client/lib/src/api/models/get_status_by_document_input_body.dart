// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_status_by_document_input_body.freezed.dart';
part 'get_status_by_document_input_body.g.dart';

@Freezed()
abstract class GetStatusByDocumentInputBody
    with _$GetStatusByDocumentInputBody {
  const factory GetStatusByDocumentInputBody({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetStatusByDocumentInputBody;

  factory GetStatusByDocumentInputBody.fromJson(Map<String, Object?> json) =>
      _$GetStatusByDocumentInputBodyFromJson(json);
}
