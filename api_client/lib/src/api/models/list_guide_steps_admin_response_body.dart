// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_guide_steps_admin_response_body.freezed.dart';
part 'list_guide_steps_admin_response_body.g.dart';

@Freezed()
abstract class ListGuideStepsAdminResponseBody with _$ListGuideStepsAdminResponseBody {
  const factory ListGuideStepsAdminResponseBody({
    required int page,
    required int pageSize,
    required List<dynamic>? steps,
    required int totalItems,
    required int totalPages,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListGuideStepsAdminResponseBody;

  factory ListGuideStepsAdminResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListGuideStepsAdminResponseBodyFromJson(json);
}
