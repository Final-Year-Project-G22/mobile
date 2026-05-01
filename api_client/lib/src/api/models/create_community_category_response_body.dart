// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_community_category_response_body.freezed.dart';
part 'create_community_category_response_body.g.dart';

@Freezed()
abstract class CreateCommunityCategoryResponseBody
    with _$CreateCommunityCategoryResponseBody {
  const factory CreateCommunityCategoryResponseBody({
    /// Created category ID
    required String id,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _CreateCommunityCategoryResponseBody;

  factory CreateCommunityCategoryResponseBody.fromJson(
    Map<String, Object?> json,
  ) => _$CreateCommunityCategoryResponseBodyFromJson(json);
}
