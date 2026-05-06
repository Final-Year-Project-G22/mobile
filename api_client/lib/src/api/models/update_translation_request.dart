// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_translation_request.freezed.dart';
part 'update_translation_request.g.dart';

@Freezed()
abstract class UpdateTranslationRequest with _$UpdateTranslationRequest {
  const factory UpdateTranslationRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Multi-channel localized content
    Map<String, dynamic>? content,

    /// Localized subject
    String? subject,
  }) = _UpdateTranslationRequest;

  factory UpdateTranslationRequest.fromJson(Map<String, Object?> json) => _$UpdateTranslationRequestFromJson(json);
}
