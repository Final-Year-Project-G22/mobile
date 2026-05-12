// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_sector_request.freezed.dart';
part 'update_sector_request.g.dart';

@Freezed()
abstract class UpdateSectorRequest with _$UpdateSectorRequest {
  const factory UpdateSectorRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Amharic description
    String? descAm,

    /// English description
    String? descEn,

    /// Icon identifier
    String? icon,

    /// Whether sector is active
    bool? isActive,

    /// Amharic name
    String? nameAm,

    /// English name
    String? nameEn,

    /// Parent sector ID
    String? parentId,

    /// Sector slug
    String? slug,

    /// Display order
    int? sortOrder,
  }) = _UpdateSectorRequest;

  factory UpdateSectorRequest.fromJson(Map<String, Object?> json) => _$UpdateSectorRequestFromJson(json);
}
