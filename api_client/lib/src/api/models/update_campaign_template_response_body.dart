// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_campaign_template_response_body.freezed.dart';
part 'update_campaign_template_response_body.g.dart';

@Freezed()
abstract class UpdateCampaignTemplateResponseBody with _$UpdateCampaignTemplateResponseBody {
  const factory UpdateCampaignTemplateResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateCampaignTemplateResponseBody;

  factory UpdateCampaignTemplateResponseBody.fromJson(Map<String, Object?> json) =>
      _$UpdateCampaignTemplateResponseBodyFromJson(json);
}
