// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_translation_request.freezed.dart';
part 'add_translation_request.g.dart';

@Freezed()
abstract class AddTranslationRequest with _$AddTranslationRequest {
  const factory AddTranslationRequest({
    /// Multi-channel localized content
    required Map<String, dynamic> content,

    /// Language code
    required String language,

    /// Localized subject
    required String subject,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AddTranslationRequest;

  factory AddTranslationRequest.fromJson(Map<String, Object?> json) =>
      _$AddTranslationRequestFromJson(json);
}
