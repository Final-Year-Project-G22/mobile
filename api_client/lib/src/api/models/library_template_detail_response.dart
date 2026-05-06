// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_template_detail_response.freezed.dart';
part 'library_template_detail_response.g.dart';

@Freezed()
abstract class LibraryTemplateDetailResponse with _$LibraryTemplateDetailResponse {
  const factory LibraryTemplateDetailResponse({
    /// MIME type
    required String contentType,

    /// File size in bytes
    required int fileSize,

    /// Group ID
    required String groupId,

    /// Template ID
    required String id,

    /// Active flag
    required bool isActive,

    /// Language code
    required String language,

    /// Template title
    required String title,

    /// Version number
    required int version,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Template description
    String? description,

    /// File URL
    String? fileUrl,
  }) = _LibraryTemplateDetailResponse;

  factory LibraryTemplateDetailResponse.fromJson(Map<String, Object?> json) =>
      _$LibraryTemplateDetailResponseFromJson(json);
}
