// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_translation_response_body.freezed.dart';
part 'add_translation_response_body.g.dart';

@Freezed()
abstract class AddTranslationResponseBody with _$AddTranslationResponseBody {
  const factory AddTranslationResponseBody({
    /// Created translation ID
    required String id,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AddTranslationResponseBody;

  factory AddTranslationResponseBody.fromJson(Map<String, Object?> json) =>
      _$AddTranslationResponseBodyFromJson(json);
}
