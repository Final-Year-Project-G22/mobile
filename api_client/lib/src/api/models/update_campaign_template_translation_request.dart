// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_campaign_template_translation_request.freezed.dart';
part 'update_campaign_template_translation_request.g.dart';

@Freezed()
abstract class UpdateCampaignTemplateTranslationRequest
    with _$UpdateCampaignTemplateTranslationRequest {
  const factory UpdateCampaignTemplateTranslationRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Multi-channel localized content
    Map<String, dynamic>? content,
  }) = _UpdateCampaignTemplateTranslationRequest;

  factory UpdateCampaignTemplateTranslationRequest.fromJson(
    Map<String, Object?> json,
  ) => _$UpdateCampaignTemplateTranslationRequestFromJson(json);
}
