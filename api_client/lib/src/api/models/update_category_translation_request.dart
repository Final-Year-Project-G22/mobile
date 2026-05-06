// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_category_translation_request.freezed.dart';
part 'update_category_translation_request.g.dart';

@Freezed()
abstract class UpdateCategoryTranslationRequest with _$UpdateCategoryTranslationRequest {
  const factory UpdateCategoryTranslationRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Translated description
    String? description,

    /// Translated name
    String? name,
  }) = _UpdateCategoryTranslationRequest;

  factory UpdateCategoryTranslationRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateCategoryTranslationRequestFromJson(json);
}
