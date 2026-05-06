// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_category_response_body.freezed.dart';
part 'create_category_response_body.g.dart';

@Freezed()
abstract class CreateCategoryResponseBody with _$CreateCategoryResponseBody {
  const factory CreateCategoryResponseBody({
    /// Created category ID
    required String id,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _CreateCategoryResponseBody;

  factory CreateCategoryResponseBody.fromJson(Map<String, Object?> json) => _$CreateCategoryResponseBodyFromJson(json);
}
