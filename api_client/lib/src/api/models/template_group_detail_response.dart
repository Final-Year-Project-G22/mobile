// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_group_detail_response.freezed.dart';
part 'template_group_detail_response.g.dart';

@Freezed()
abstract class TemplateGroupDetailResponse with _$TemplateGroupDetailResponse {
  const factory TemplateGroupDetailResponse({
    /// Category ID
    required String categoryId,

    /// Creation time
    required DateTime createdAt,

    /// Creator account ID
    required String createdBy,

    /// Default language code
    required String defaultLanguage,

    /// Total downloads
    required int downloadCount,

    /// Template format
    required String format,

    /// Group ID
    required String id,

    /// Active flag
    required bool isActive,

    /// Group name
    required String name,

    /// Requires authentication
    required bool requiresAuth,

    /// Group slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// Tier access level
    required String tierAccess,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Group description
    String? description,

    /// Language variants
    List<dynamic>? templates,

    /// Thumbnail URL
    String? thumbnailUrl,
  }) = _TemplateGroupDetailResponse;

  factory TemplateGroupDetailResponse.fromJson(Map<String, Object?> json) =>
      _$TemplateGroupDetailResponseFromJson(json);
}
