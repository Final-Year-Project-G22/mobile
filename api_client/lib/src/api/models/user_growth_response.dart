// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_growth_response.freezed.dart';
part 'user_growth_response.g.dart';

@Freezed()
abstract class UserGrowthResponse with _$UserGrowthResponse {
  const factory UserGrowthResponse({
    required List<dynamic>? data,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UserGrowthResponse;

  factory UserGrowthResponse.fromJson(Map<String, Object?> json) =>
      _$UserGrowthResponseFromJson(json);
}
