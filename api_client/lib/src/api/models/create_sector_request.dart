// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_sector_request.freezed.dart';
part 'create_sector_request.g.dart';

@Freezed()
abstract class CreateSectorRequest with _$CreateSectorRequest {
  const factory CreateSectorRequest({
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

    /// Amharic description
    String? descAm,

    /// English description
    String? descEn,

    /// Icon identifier
    String? icon,

    /// Parent sector ID
    String? parentId,
  }) = _CreateSectorRequest;

  factory CreateSectorRequest.fromJson(Map<String, Object?> json) => _$CreateSectorRequestFromJson(json);
}
