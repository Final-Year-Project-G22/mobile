// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_guide_translations_response_body.freezed.dart';
part 'set_guide_translations_response_body.g.dart';

@Freezed()
abstract class SetGuideTranslationsResponseBody with _$SetGuideTranslationsResponseBody {
  const factory SetGuideTranslationsResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _SetGuideTranslationsResponseBody;

  factory SetGuideTranslationsResponseBody.fromJson(Map<String, Object?> json) =>
      _$SetGuideTranslationsResponseBodyFromJson(json);
}
