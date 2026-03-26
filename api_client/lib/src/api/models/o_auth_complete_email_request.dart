// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'o_auth_complete_email_request.freezed.dart';
part 'o_auth_complete_email_request.g.dart';

@Freezed()
abstract class OAuthCompleteEmailRequest with _$OAuthCompleteEmailRequest {
  const factory OAuthCompleteEmailRequest({
    /// Email address
    required String email,

    /// State token
    required String state,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _OAuthCompleteEmailRequest;

  factory OAuthCompleteEmailRequest.fromJson(Map<String, Object?> json) =>
      _$OAuthCompleteEmailRequestFromJson(json);
}
