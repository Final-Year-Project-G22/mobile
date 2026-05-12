// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'guide_category_tree_admin_response_body.freezed.dart';
part 'guide_category_tree_admin_response_body.g.dart';

@Freezed()
abstract class GuideCategoryTreeAdminResponseBody
    with _$GuideCategoryTreeAdminResponseBody {
  const factory GuideCategoryTreeAdminResponseBody({
    required List<dynamic>? categories,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GuideCategoryTreeAdminResponseBody;

  factory GuideCategoryTreeAdminResponseBody.fromJson(
    Map<String, Object?> json,
  ) => _$GuideCategoryTreeAdminResponseBodyFromJson(json);
}
