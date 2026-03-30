// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'account_dto.dart';
import 'o_auth_email_required_response.dart';
import 'user_dto.dart';

part 'o_auth_callback_response.freezed.dart';
part 'o_auth_callback_response.g.dart';

@Freezed()
abstract class OAuthCallbackResponse with _$OAuthCallbackResponse {
  const factory OAuthCallbackResponse({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
    String? accessToken,
    AccountDto? account,
    OAuthEmailRequiredResponse? emailRequired,
    DateTime? expiresAt,
    bool? isNewUser,
    String? refreshToken,
    UserDto? user,
  }) = _OAuthCallbackResponse;

  factory OAuthCallbackResponse.fromJson(Map<String, Object?> json) =>
      _$OAuthCallbackResponseFromJson(json);
}
