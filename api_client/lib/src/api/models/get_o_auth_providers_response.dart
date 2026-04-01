// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_o_auth_providers_response.freezed.dart';
part 'get_o_auth_providers_response.g.dart';

@Freezed()
abstract class GetOAuthProvidersResponse with _$GetOAuthProvidersResponse {
  const factory GetOAuthProvidersResponse({
    required List<dynamic>? providers,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetOAuthProvidersResponse;

  factory GetOAuthProvidersResponse.fromJson(Map<String, Object?> json) => _$GetOAuthProvidersResponseFromJson(json);
}
