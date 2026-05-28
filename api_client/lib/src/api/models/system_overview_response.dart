// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_overview_response.freezed.dart';
part 'system_overview_response.g.dart';

@Freezed()
abstract class SystemOverviewResponse with _$SystemOverviewResponse {
  const factory SystemOverviewResponse({
    required List<dynamic>? items,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _SystemOverviewResponse;

  factory SystemOverviewResponse.fromJson(Map<String, Object?> json) =>
      _$SystemOverviewResponseFromJson(json);
}
