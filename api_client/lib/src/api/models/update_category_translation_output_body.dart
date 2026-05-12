// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_category_translation_output_body.freezed.dart';
part 'update_category_translation_output_body.g.dart';

@Freezed()
abstract class UpdateCategoryTranslationOutputBody with _$UpdateCategoryTranslationOutputBody {
  const factory UpdateCategoryTranslationOutputBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateCategoryTranslationOutputBody;

  factory UpdateCategoryTranslationOutputBody.fromJson(Map<String, Object?> json) =>
      _$UpdateCategoryTranslationOutputBodyFromJson(json);
}
