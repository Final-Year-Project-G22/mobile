// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign_template_translation_response.freezed.dart';
part 'campaign_template_translation_response.g.dart';

@Freezed()
abstract class CampaignTemplateTranslationResponse with _$CampaignTemplateTranslationResponse {
  const factory CampaignTemplateTranslationResponse({
    /// Multi-channel localized content
    required Map<String, dynamic> content,

    /// Translation ID
    required String id,

    /// Language code
    required String language,
  }) = _CampaignTemplateTranslationResponse;

  factory CampaignTemplateTranslationResponse.fromJson(Map<String, Object?> json) =>
      _$CampaignTemplateTranslationResponseFromJson(json);
}
