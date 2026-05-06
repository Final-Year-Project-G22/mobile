// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_guide_translation.freezed.dart';
part 'create_guide_translation.g.dart';

@Freezed()
abstract class CreateGuideTranslation with _$CreateGuideTranslation {
  const factory CreateGuideTranslation({
    /// Language code (en, am)
    required String language,

    /// Localized name
    required String name,

    /// Localized description
    String? description,
  }) = _CreateGuideTranslation;

  factory CreateGuideTranslation.fromJson(Map<String, Object?> json) => _$CreateGuideTranslationFromJson(json);
}
