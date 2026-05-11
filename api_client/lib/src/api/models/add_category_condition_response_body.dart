// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_category_condition_response_body.freezed.dart';
part 'add_category_condition_response_body.g.dart';

@Freezed()
abstract class AddCategoryConditionResponseBody
    with _$AddCategoryConditionResponseBody {
  const factory AddCategoryConditionResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AddCategoryConditionResponseBody;

  factory AddCategoryConditionResponseBody.fromJson(
    Map<String, Object?> json,
  ) => _$AddCategoryConditionResponseBodyFromJson(json);
}
