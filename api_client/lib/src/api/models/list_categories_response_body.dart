// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_categories_response_body.freezed.dart';
part 'list_categories_response_body.g.dart';

@Freezed()
abstract class ListCategoriesResponseBody with _$ListCategoriesResponseBody {
  const factory ListCategoriesResponseBody({
    /// Category list
    required List<dynamic>? categories,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListCategoriesResponseBody;

  factory ListCategoriesResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListCategoriesResponseBodyFromJson(json);
}
