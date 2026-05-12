// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_step_translation.freezed.dart';
part 'update_step_translation.g.dart';

@Freezed()
abstract class UpdateStepTranslation with _$UpdateStepTranslation {
  const factory UpdateStepTranslation({
    /// Language code (en, am)
    required String language,

    /// Localized title
    required String title,

    /// Localized description
    String? description,

    /// Rich content as JSON
    dynamic detailedContent,
  }) = _UpdateStepTranslation;

  factory UpdateStepTranslation.fromJson(Map<String, Object?> json) => _$UpdateStepTranslationFromJson(json);
}
