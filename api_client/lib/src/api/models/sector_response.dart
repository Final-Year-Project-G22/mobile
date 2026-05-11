// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sector_response.freezed.dart';
part 'sector_response.g.dart';

@Freezed()
abstract class SectorResponse with _$SectorResponse {
  const factory SectorResponse({
    /// Sector ID
    required String id,

    /// Whether sector is active
    required bool isActive,

    /// Amharic name
    required String nameAm,

    /// English name
    required String nameEn,

    /// Sector slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Created timestamp
    DateTime? createdAt,

    /// Amharic description
    String? descAm,

    /// English description
    String? descEn,

    /// Icon identifier
    String? icon,

    /// Parent sector ID
    String? parentId,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _SectorResponse;

  factory SectorResponse.fromJson(Map<String, Object?> json) =>
      _$SectorResponseFromJson(json);
}
