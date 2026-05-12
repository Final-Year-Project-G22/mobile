// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'invalidate_all_journeys_response_body.freezed.dart';
part 'invalidate_all_journeys_response_body.g.dart';

@Freezed()
abstract class InvalidateAllJourneysResponseBody
    with _$InvalidateAllJourneysResponseBody {
  const factory InvalidateAllJourneysResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _InvalidateAllJourneysResponseBody;

  factory InvalidateAllJourneysResponseBody.fromJson(
    Map<String, Object?> json,
  ) => _$InvalidateAllJourneysResponseBodyFromJson(json);
}
