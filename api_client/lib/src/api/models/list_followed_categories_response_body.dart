// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_followed_categories_response_body.freezed.dart';
part 'list_followed_categories_response_body.g.dart';

@Freezed()
abstract class ListFollowedCategoriesResponseBody with _$ListFollowedCategoriesResponseBody {
  const factory ListFollowedCategoriesResponseBody({
    /// Followed categories
    required List<dynamic>? categories,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListFollowedCategoriesResponseBody;

  factory ListFollowedCategoriesResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListFollowedCategoriesResponseBodyFromJson(json);
}
