// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_guide_request.freezed.dart';
part 'create_guide_request.g.dart';

@Freezed()
abstract class CreateGuideRequest with _$CreateGuideRequest {
  const factory CreateGuideRequest({
    /// Target sector IDs
    required List<dynamic>? sectorIds,

    /// Guide slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// Target tag IDs
    required List<dynamic>? tagIds,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Visibility conditions
    List<dynamic>? conditions,

    /// Icon identifier
    String? icon,

    /// Localized translations
    List<dynamic>? translations,
  }) = _CreateGuideRequest;

  factory CreateGuideRequest.fromJson(Map<String, Object?> json) =>
      _$CreateGuideRequestFromJson(json);
}
