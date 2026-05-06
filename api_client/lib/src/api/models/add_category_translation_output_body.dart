// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_category_translation_output_body.freezed.dart';
part 'add_category_translation_output_body.g.dart';

@Freezed()
abstract class AddCategoryTranslationOutputBody with _$AddCategoryTranslationOutputBody {
  const factory AddCategoryTranslationOutputBody({
    /// Translation ID
    required String id,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AddCategoryTranslationOutputBody;

  factory AddCategoryTranslationOutputBody.fromJson(Map<String, Object?> json) =>
      _$AddCategoryTranslationOutputBodyFromJson(json);
}
