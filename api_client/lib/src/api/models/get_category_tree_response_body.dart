// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_category_tree_response_body.freezed.dart';
part 'get_category_tree_response_body.g.dart';

@Freezed()
abstract class GetCategoryTreeResponseBody with _$GetCategoryTreeResponseBody {
  const factory GetCategoryTreeResponseBody({
    required List<dynamic>? categories,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetCategoryTreeResponseBody;

  factory GetCategoryTreeResponseBody.fromJson(Map<String, Object?> json) =>
      _$GetCategoryTreeResponseBodyFromJson(json);
}
