// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_guides_admin_response_body.freezed.dart';
part 'list_guides_admin_response_body.g.dart';

@Freezed()
abstract class ListGuidesAdminResponseBody with _$ListGuidesAdminResponseBody {
  const factory ListGuidesAdminResponseBody({
    required List<dynamic>? guides,
    required int page,
    required int pageSize,
    required int totalItems,
    required int totalPages,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListGuidesAdminResponseBody;

  factory ListGuidesAdminResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListGuidesAdminResponseBodyFromJson(json);
}
