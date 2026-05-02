// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_translation_item.freezed.dart';
part 'category_translation_item.g.dart';

@Freezed()
abstract class CategoryTranslationItem with _$CategoryTranslationItem {
  const factory CategoryTranslationItem({
    /// Language code
    required String language,

    /// Translated name
    required String name,

    /// Translated description
    String? description,
  }) = _CategoryTranslationItem;

  factory CategoryTranslationItem.fromJson(Map<String, Object?> json) =>
      _$CategoryTranslationItemFromJson(json);
}
