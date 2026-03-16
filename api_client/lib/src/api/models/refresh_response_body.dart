// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_response_body.freezed.dart';
part 'refresh_response_body.g.dart';

@Freezed()
abstract class RefreshResponseBody with _$RefreshResponseBody {
  const factory RefreshResponseBody({
    /// New JWT access token
    required String accessToken,

    /// When the access token expires
    required DateTime expiresAt,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _RefreshResponseBody;

  factory RefreshResponseBody.fromJson(Map<String, Object?> json) =>
      _$RefreshResponseBodyFromJson(json);
}
