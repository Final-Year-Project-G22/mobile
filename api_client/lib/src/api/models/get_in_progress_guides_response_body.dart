// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_in_progress_guides_response_body.freezed.dart';
part 'get_in_progress_guides_response_body.g.dart';

@Freezed()
abstract class GetInProgressGuidesResponseBody
    with _$GetInProgressGuidesResponseBody {
  const factory GetInProgressGuidesResponseBody({
    required List<dynamic>? guides,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetInProgressGuidesResponseBody;

  factory GetInProgressGuidesResponseBody.fromJson(Map<String, Object?> json) =>
      _$GetInProgressGuidesResponseBodyFromJson(json);
}
