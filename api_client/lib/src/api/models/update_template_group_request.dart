// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_template_group_request.freezed.dart';
part 'update_template_group_request.g.dart';

@Freezed()
abstract class UpdateTemplateGroupRequest with _$UpdateTemplateGroupRequest {
  const factory UpdateTemplateGroupRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Category ID
    String? categoryId,

    /// Default language code
    String? defaultLanguage,

    /// Group description
    String? description,

    /// Template format
    String? format,

    /// Active flag
    bool? isActive,

    /// Group name
    String? name,

    /// Requires authentication
    bool? requiresAuth,

    /// Group slug
    String? slug,

    /// Display order
    int? sortOrder,

    /// Tier access level
    String? tierAccess,
  }) = _UpdateTemplateGroupRequest;

  factory UpdateTemplateGroupRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateTemplateGroupRequestFromJson(json);
}
