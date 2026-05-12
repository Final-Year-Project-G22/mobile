// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_step_translations_request.freezed.dart';
part 'set_step_translations_request.g.dart';

@Freezed()
abstract class SetStepTranslationsRequest with _$SetStepTranslationsRequest {
  const factory SetStepTranslationsRequest({
    /// Full set of translations
    required List<dynamic>? translations,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _SetStepTranslationsRequest;

  factory SetStepTranslationsRequest.fromJson(Map<String, Object?> json) =>
      _$SetStepTranslationsRequestFromJson(json);
}
