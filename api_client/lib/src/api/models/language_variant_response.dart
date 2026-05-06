// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_variant_response.freezed.dart';
part 'language_variant_response.g.dart';

@Freezed()
abstract class LanguageVariantResponse with _$LanguageVariantResponse {
  const factory LanguageVariantResponse({
    /// MIME type
    required String contentType,

    /// File size in bytes
    required int fileSize,

    /// Language code
    required String language,

    /// Template title
    required String title,

    /// Version number
    required int version,

    /// Template description
    String? description,
  }) = _LanguageVariantResponse;

  factory LanguageVariantResponse.fromJson(Map<String, Object?> json) => _$LanguageVariantResponseFromJson(json);
}
