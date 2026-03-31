// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'o_auth_identities_response.freezed.dart';
part 'o_auth_identities_response.g.dart';

@Freezed()
abstract class OAuthIdentitiesResponse with _$OAuthIdentitiesResponse {
  const factory OAuthIdentitiesResponse({
    required List<dynamic>? identities,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _OAuthIdentitiesResponse;

  factory OAuthIdentitiesResponse.fromJson(Map<String, Object?> json) => _$OAuthIdentitiesResponseFromJson(json);
}
