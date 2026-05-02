// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_category_translation_request.freezed.dart';
part 'add_category_translation_request.g.dart';

@Freezed()
abstract class AddCategoryTranslationRequest
    with _$AddCategoryTranslationRequest {
  const factory AddCategoryTranslationRequest({
    /// Language code
    required String language,

    /// Translated name
    required String name,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Translated description
    String? description,
  }) = _AddCategoryTranslationRequest;

  factory AddCategoryTranslationRequest.fromJson(Map<String, Object?> json) =>
      _$AddCategoryTranslationRequestFromJson(json);
}
