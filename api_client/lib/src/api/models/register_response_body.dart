// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'account_dto.dart';
import 'user_dto.dart';

part 'register_response_body.freezed.dart';
part 'register_response_body.g.dart';

@Freezed()
abstract class RegisterResponseBody with _$RegisterResponseBody {
  const factory RegisterResponseBody({
    /// JWT access token
    required String accessToken,

    /// Created account
    required AccountDto account,

    /// When the access token expires
    required DateTime expiresAt,

    /// Created user
    required UserDto user,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _RegisterResponseBody;

  factory RegisterResponseBody.fromJson(Map<String, Object?> json) =>
      _$RegisterResponseBodyFromJson(json);
}
