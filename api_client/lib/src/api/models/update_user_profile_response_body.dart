// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_profile_response_body.freezed.dart';
part 'update_user_profile_response_body.g.dart';

@Freezed()
abstract class UpdateUserProfileResponseBody
    with _$UpdateUserProfileResponseBody {
  const factory UpdateUserProfileResponseBody({
    /// Bio
    required String bio,

    /// First name
    required String firstName,

    /// Last name
    required String lastName,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateUserProfileResponseBody;

  factory UpdateUserProfileResponseBody.fromJson(Map<String, Object?> json) =>
      _$UpdateUserProfileResponseBodyFromJson(json);
}
