// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_register_response_body.freezed.dart';
part 'admin_register_response_body.g.dart';

@Freezed()
abstract class AdminRegisterResponseBody with _$AdminRegisterResponseBody {
  const factory AdminRegisterResponseBody({
    /// Created account ID
    required String accountId,

    /// Status message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AdminRegisterResponseBody;

  factory AdminRegisterResponseBody.fromJson(Map<String, Object?> json) => _$AdminRegisterResponseBodyFromJson(json);
}
