// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_community_category_response_body.freezed.dart';
part 'delete_community_category_response_body.g.dart';

@Freezed()
abstract class DeleteCommunityCategoryResponseBody with _$DeleteCommunityCategoryResponseBody {
  const factory DeleteCommunityCategoryResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _DeleteCommunityCategoryResponseBody;

  factory DeleteCommunityCategoryResponseBody.fromJson(Map<String, Object?> json) =>
      _$DeleteCommunityCategoryResponseBodyFromJson(json);
}
