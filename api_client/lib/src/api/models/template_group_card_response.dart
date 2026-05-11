// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_group_card_response.freezed.dart';
part 'template_group_card_response.g.dart';

@Freezed()
abstract class TemplateGroupCardResponse with _$TemplateGroupCardResponse {
  const factory TemplateGroupCardResponse({
    /// Category ID
    required String categoryId,

    /// Total downloads
    required int downloadCount,

    /// Template format
    required String format,

    /// Group ID
    required String id,

    /// Available language codes
    required List<dynamic>? languages,

    /// Group name
    required String name,

    /// Group slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// Tier access level
    required String tierAccess,

    /// Thumbnail URL
    String? thumbnailUrl,
  }) = _TemplateGroupCardResponse;

  factory TemplateGroupCardResponse.fromJson(Map<String, Object?> json) =>
      _$TemplateGroupCardResponseFromJson(json);
}
