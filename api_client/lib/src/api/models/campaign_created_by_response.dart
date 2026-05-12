// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign_created_by_response.freezed.dart';
part 'campaign_created_by_response.g.dart';

@Freezed()
abstract class CampaignCreatedByResponse with _$CampaignCreatedByResponse {
  const factory CampaignCreatedByResponse({
    /// Account email
    required String email,

    /// Account ID
    required String id,

    /// Account name
    required String name,
  }) = _CampaignCreatedByResponse;

  factory CampaignCreatedByResponse.fromJson(Map<String, Object?> json) =>
      _$CampaignCreatedByResponseFromJson(json);
}
