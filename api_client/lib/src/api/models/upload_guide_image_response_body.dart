// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_guide_image_response_body.freezed.dart';
part 'upload_guide_image_response_body.g.dart';

@Freezed()
abstract class UploadGuideImageResponseBody
    with _$UploadGuideImageResponseBody {
  const factory UploadGuideImageResponseBody({
    /// Uploaded image URL
    required String imageUrl,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UploadGuideImageResponseBody;

  factory UploadGuideImageResponseBody.fromJson(Map<String, Object?> json) =>
      _$UploadGuideImageResponseBodyFromJson(json);
}
