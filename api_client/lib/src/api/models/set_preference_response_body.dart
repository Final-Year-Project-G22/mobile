// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_preference_response_body.freezed.dart';
part 'set_preference_response_body.g.dart';

@Freezed()
abstract class SetPreferenceResponseBody with _$SetPreferenceResponseBody {
  const factory SetPreferenceResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _SetPreferenceResponseBody;

  factory SetPreferenceResponseBody.fromJson(Map<String, Object?> json) =>
      _$SetPreferenceResponseBodyFromJson(json);
}
