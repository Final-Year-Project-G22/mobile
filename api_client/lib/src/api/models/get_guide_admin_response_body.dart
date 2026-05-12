// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'admin_guide_detail_dto.dart';

part 'get_guide_admin_response_body.freezed.dart';
part 'get_guide_admin_response_body.g.dart';

@Freezed()
abstract class GetGuideAdminResponseBody with _$GetGuideAdminResponseBody {
  const factory GetGuideAdminResponseBody({
    required AdminGuideDetailDto guide,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetGuideAdminResponseBody;

  factory GetGuideAdminResponseBody.fromJson(Map<String, Object?> json) =>
      _$GetGuideAdminResponseBodyFromJson(json);
}
