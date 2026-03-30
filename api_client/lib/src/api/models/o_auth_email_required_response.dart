// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'o_auth_email_required_response.freezed.dart';
part 'o_auth_email_required_response.g.dart';

@Freezed()
abstract class OAuthEmailRequiredResponse with _$OAuthEmailRequiredResponse {
  const factory OAuthEmailRequiredResponse({
    required String firstName,
    required String lastName,
    required String name,
    required String provider,
    required String state,
    required String subject,
    String? pictureUrl,
  }) = _OAuthEmailRequiredResponse;

  factory OAuthEmailRequiredResponse.fromJson(Map<String, Object?> json) => _$OAuthEmailRequiredResponseFromJson(json);
}
