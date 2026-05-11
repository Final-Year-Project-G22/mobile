// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_guide_request.freezed.dart';
part 'update_guide_request.g.dart';

@Freezed()
abstract class UpdateGuideRequest with _$UpdateGuideRequest {
  const factory UpdateGuideRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Visibility conditions
    List<dynamic>? conditions,

    /// Icon identifier
    String? icon,

    /// Target sector IDs
    List<dynamic>? sectorIds,

    /// Guide slug
    String? slug,

    /// Display order
    int? sortOrder,

    /// Target tag IDs
    List<dynamic>? tagIds,

    /// Localized translations
    List<dynamic>? translations,
  }) = _UpdateGuideRequest;

  factory UpdateGuideRequest.fromJson(Map<String, Object?> json) => _$UpdateGuideRequestFromJson(json);
}
