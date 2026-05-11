// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'account_dto.dart';
import 'user_dto.dart';

part 'login_response_body.freezed.dart';
part 'login_response_body.g.dart';

@Freezed()
abstract class LoginResponseBody with _$LoginResponseBody {
  const factory LoginResponseBody({
    /// JWT access token
    required String accessToken,

    /// Authenticated account
    required AccountDto account,

    /// When the access token expires
    required DateTime expiresAt,

    /// Authenticated user
    required UserDto user,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _LoginResponseBody;

  factory LoginResponseBody.fromJson(Map<String, Object?> json) =>
      _$LoginResponseBodyFromJson(json);
}
