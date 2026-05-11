// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_step_translation.freezed.dart';
part 'create_step_translation.g.dart';

@Freezed()
abstract class CreateStepTranslation with _$CreateStepTranslation {
  const factory CreateStepTranslation({
    /// Language code (en, am)
    required String language,

    /// Localized title
    required String title,

    /// Localized description
    String? description,

    /// Rich content as JSON
    dynamic detailedContent,
  }) = _CreateStepTranslation;

  factory CreateStepTranslation.fromJson(Map<String, Object?> json) => _$CreateStepTranslationFromJson(json);
}
