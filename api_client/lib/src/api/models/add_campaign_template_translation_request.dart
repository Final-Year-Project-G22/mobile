// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_campaign_template_translation_request.freezed.dart';
part 'add_campaign_template_translation_request.g.dart';

@Freezed()
abstract class AddCampaignTemplateTranslationRequest
    with _$AddCampaignTemplateTranslationRequest {
  const factory AddCampaignTemplateTranslationRequest({
    /// Multi-channel localized content
    required Map<String, dynamic> content,

    /// Language code
    required String language,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AddCampaignTemplateTranslationRequest;

  factory AddCampaignTemplateTranslationRequest.fromJson(
    Map<String, Object?> json,
  ) => _$AddCampaignTemplateTranslationRequestFromJson(json);
}
