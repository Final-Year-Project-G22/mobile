// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_response.freezed.dart';
part 'translation_response.g.dart';

@Freezed()
abstract class TranslationResponse with _$TranslationResponse {
  const factory TranslationResponse({
    /// Multi-channel localized content
    required Map<String, dynamic> content,

    /// Translation ID
    required String id,

    /// Language code
    required String language,

    /// Localized subject
    required String subject,
  }) = _TranslationResponse;

  factory TranslationResponse.fromJson(Map<String, Object?> json) =>
      _$TranslationResponseFromJson(json);
}
