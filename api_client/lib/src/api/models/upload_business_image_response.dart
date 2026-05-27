// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_business_image_response.freezed.dart';
part 'upload_business_image_response.g.dart';

@Freezed()
abstract class UploadBusinessImageResponse with _$UploadBusinessImageResponse {
  const factory UploadBusinessImageResponse({
    required String imageUrl,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UploadBusinessImageResponse;

  factory UploadBusinessImageResponse.fromJson(Map<String, Object?> json) =>
      _$UploadBusinessImageResponseFromJson(json);
}
