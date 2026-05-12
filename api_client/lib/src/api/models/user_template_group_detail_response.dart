// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_template_group_detail_response.freezed.dart';
part 'user_template_group_detail_response.g.dart';

@Freezed()
abstract class UserTemplateGroupDetailResponse
    with _$UserTemplateGroupDetailResponse {
  const factory UserTemplateGroupDetailResponse({
    /// Category ID
    required String categoryId,

    /// Default language code
    required String defaultLanguage,

    /// Total downloads
    required int downloadCount,

    /// Template format
    required String format,

    /// Group ID
    required String id,

    /// Available language variants
    required List<dynamic>? languages,

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

    /// Thumbnail URL
    String? thumbnailUrl,
  }) = _UserTemplateGroupDetailResponse;

  factory UserTemplateGroupDetailResponse.fromJson(Map<String, Object?> json) =>
      _$UserTemplateGroupDetailResponseFromJson(json);
}
