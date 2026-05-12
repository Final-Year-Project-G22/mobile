// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_template_group_request.freezed.dart';
part 'create_template_group_request.g.dart';

@Freezed()
abstract class CreateTemplateGroupRequest with _$CreateTemplateGroupRequest {
  const factory CreateTemplateGroupRequest({
    /// Category ID
    required String categoryId,

    /// Default language code
    required String defaultLanguage,

    /// Template format
    required String format,

    /// Group name
    required String name,

    /// Requires authentication
    required bool requiresAuth,

    /// URL-friendly identifier
    required String slug,

    /// Display order
    required int sortOrder,

    /// Tier access level
    required String tierAccess,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Group description
    String? description,
  }) = _CreateTemplateGroupRequest;

  factory CreateTemplateGroupRequest.fromJson(Map<String, Object?> json) =>
      _$CreateTemplateGroupRequestFromJson(json);
}
