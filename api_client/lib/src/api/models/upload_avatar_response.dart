// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_avatar_response.freezed.dart';
part 'upload_avatar_response.g.dart';

@Freezed()
abstract class UploadAvatarResponse with _$UploadAvatarResponse {
  const factory UploadAvatarResponse({
    required String imageUrl,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UploadAvatarResponse;

  factory UploadAvatarResponse.fromJson(Map<String, Object?> json) => _$UploadAvatarResponseFromJson(json);
}
