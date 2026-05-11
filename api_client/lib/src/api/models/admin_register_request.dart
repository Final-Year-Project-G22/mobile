// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_register_request.freezed.dart';
part 'admin_register_request.g.dart';

@Freezed()
abstract class AdminRegisterRequest with _$AdminRegisterRequest {
  const factory AdminRegisterRequest({
    /// Email address
    required String email,

    /// First name
    required String firstName,

    /// Last name
    required String lastName,

    /// Role IDs
    required List<dynamic>? roleIds,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Username (lowercase letters, digits, underscore)
    String? username,
  }) = _AdminRegisterRequest;

  factory AdminRegisterRequest.fromJson(Map<String, Object?> json) => _$AdminRegisterRequestFromJson(json);
}
