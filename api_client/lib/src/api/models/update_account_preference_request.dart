// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_account_preference_request.freezed.dart';
part 'update_account_preference_request.g.dart';

@Freezed()
abstract class UpdateAccountPreferenceRequest
    with _$UpdateAccountPreferenceRequest {
  const factory UpdateAccountPreferenceRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Language code (en, am)
    String? language,
  }) = _UpdateAccountPreferenceRequest;

  factory UpdateAccountPreferenceRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateAccountPreferenceRequestFromJson(json);
}
