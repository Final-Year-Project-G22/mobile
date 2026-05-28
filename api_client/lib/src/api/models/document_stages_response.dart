// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_stages_response.freezed.dart';
part 'document_stages_response.g.dart';

@Freezed()
abstract class DocumentStagesResponse with _$DocumentStagesResponse {
  const factory DocumentStagesResponse({
    required List<dynamic>? data,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _DocumentStagesResponse;

  factory DocumentStagesResponse.fromJson(Map<String, Object?> json) =>
      _$DocumentStagesResponseFromJson(json);
}
