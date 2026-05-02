// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_category_translation.freezed.dart';
part 'update_category_translation.g.dart';

@Freezed()
abstract class UpdateCategoryTranslation with _$UpdateCategoryTranslation {
  const factory UpdateCategoryTranslation({
    /// Language code (en, am)
    required String language,

    /// Localized name
    required String name,

    /// Localized description
    String? description,
  }) = _UpdateCategoryTranslation;

  factory UpdateCategoryTranslation.fromJson(Map<String, Object?> json) =>
      _$UpdateCategoryTranslationFromJson(json);
}
