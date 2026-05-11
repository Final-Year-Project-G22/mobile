// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_campaign_template_translation_response_body.freezed.dart';
part 'add_campaign_template_translation_response_body.g.dart';

@Freezed()
abstract class AddCampaignTemplateTranslationResponseBody with _$AddCampaignTemplateTranslationResponseBody {
  const factory AddCampaignTemplateTranslationResponseBody({
    /// Created translation ID
    required String id,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AddCampaignTemplateTranslationResponseBody;

  factory AddCampaignTemplateTranslationResponseBody.fromJson(Map<String, Object?> json) =>
      _$AddCampaignTemplateTranslationResponseBodyFromJson(json);
}
