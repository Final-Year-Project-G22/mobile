// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'interactive_form_detail_response.freezed.dart';
part 'interactive_form_detail_response.g.dart';

@Freezed()
abstract class InteractiveFormDetailResponse
    with _$InteractiveFormDetailResponse {
  const factory InteractiveFormDetailResponse({
    /// Form layout JSON
    required Map<String, dynamic> formLayout,

    /// Form ID
    required String id,

    /// Active flag
    required bool isActive,

    /// Form name
    required String name,

    /// Template ID
    required String templateId,

    /// Version number
    required int version,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Form description
    String? description,
  }) = _InteractiveFormDetailResponse;

  factory InteractiveFormDetailResponse.fromJson(Map<String, Object?> json) =>
      _$InteractiveFormDetailResponseFromJson(json);
}
