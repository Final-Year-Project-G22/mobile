// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_guides_response_body.freezed.dart';
part 'list_guides_response_body.g.dart';

@Freezed()
abstract class ListGuidesResponseBody with _$ListGuidesResponseBody {
  const factory ListGuidesResponseBody({
    required List<dynamic>? guides,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListGuidesResponseBody;

  factory ListGuidesResponseBody.fromJson(Map<String, Object?> json) => _$ListGuidesResponseBodyFromJson(json);
}
