// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_profile_request.freezed.dart';
part 'update_user_profile_request.g.dart';

@Freezed()
abstract class UpdateUserProfileRequest with _$UpdateUserProfileRequest {
  const factory UpdateUserProfileRequest({
    /// First name
    required String firstName,

    /// Last name
    required String lastName,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Bio
    String? bio,
  }) = _UpdateUserProfileRequest;

  factory UpdateUserProfileRequest.fromJson(Map<String, Object?> json) => _$UpdateUserProfileRequestFromJson(json);
}
