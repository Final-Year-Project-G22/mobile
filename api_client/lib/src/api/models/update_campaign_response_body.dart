// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_campaign_response_body.freezed.dart';
part 'update_campaign_response_body.g.dart';

@Freezed()
abstract class UpdateCampaignResponseBody with _$UpdateCampaignResponseBody {
  const factory UpdateCampaignResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateCampaignResponseBody;

  factory UpdateCampaignResponseBody.fromJson(Map<String, Object?> json) => _$UpdateCampaignResponseBodyFromJson(json);
}
