// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_preference_response.freezed.dart';
part 'account_preference_response.g.dart';

@Freezed()
abstract class AccountPreferenceResponse with _$AccountPreferenceResponse {
  const factory AccountPreferenceResponse({
    /// User's language preference (en, am)
    required String language,

    /// User's timezone (e.g. UTC, Africa/Addis_Ababa)
    required String timezone,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AccountPreferenceResponse;

  factory AccountPreferenceResponse.fromJson(Map<String, Object?> json) =>
      _$AccountPreferenceResponseFromJson(json);
}
