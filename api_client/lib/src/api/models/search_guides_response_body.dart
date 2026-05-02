// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_guides_response_body.freezed.dart';
part 'search_guides_response_body.g.dart';

@Freezed()
abstract class SearchGuidesResponseBody with _$SearchGuidesResponseBody {
  const factory SearchGuidesResponseBody({
    required List<dynamic>? guides,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _SearchGuidesResponseBody;

  factory SearchGuidesResponseBody.fromJson(Map<String, Object?> json) =>
      _$SearchGuidesResponseBodyFromJson(json);
}
