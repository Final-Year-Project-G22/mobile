// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@Freezed()
abstract class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    /// Email address
    required String email,

    /// First name
    required String firstName,

    /// Last name
    required String lastName,

    /// Password (min 8 chars, 1 uppercase, 1 lowercase, 1 digit)
    required String password,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Username (lowercase letters, digits, underscore)
    String? username,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, Object?> json) => _$RegisterRequestFromJson(json);
}
