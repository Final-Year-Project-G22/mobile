// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_translation_response_body.freezed.dart';
part 'update_translation_response_body.g.dart';

@Freezed()
abstract class UpdateTranslationResponseBody
    with _$UpdateTranslationResponseBody {
  const factory UpdateTranslationResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateTranslationResponseBody;

  factory UpdateTranslationResponseBody.fromJson(Map<String, Object?> json) =>
      _$UpdateTranslationResponseBodyFromJson(json);
}
