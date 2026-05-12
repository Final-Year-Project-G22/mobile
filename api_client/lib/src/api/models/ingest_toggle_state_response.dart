// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingest_toggle_state_response.freezed.dart';
part 'ingest_toggle_state_response.g.dart';

@Freezed()
abstract class IngestToggleStateResponse with _$IngestToggleStateResponse {
  const factory IngestToggleStateResponse({
    required bool enabled,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _IngestToggleStateResponse;

  factory IngestToggleStateResponse.fromJson(Map<String, Object?> json) => _$IngestToggleStateResponseFromJson(json);
}
