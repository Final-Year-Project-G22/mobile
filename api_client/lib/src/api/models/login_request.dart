// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

@Freezed()
abstract class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    /// Email address
    required String email,

    /// Password
    required String password,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, Object?> json) => _$LoginRequestFromJson(json);
}
