// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_category_translation.freezed.dart';
part 'create_category_translation.g.dart';

@Freezed()
abstract class CreateCategoryTranslation with _$CreateCategoryTranslation {
  const factory CreateCategoryTranslation({
    /// Language code (en, am)
    required String language,

    /// Localized name
    required String name,

    /// Localized description
    String? description,
  }) = _CreateCategoryTranslation;

  factory CreateCategoryTranslation.fromJson(Map<String, Object?> json) => _$CreateCategoryTranslationFromJson(json);
}
