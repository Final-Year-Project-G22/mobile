// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread_content_dto.freezed.dart';
part 'thread_content_dto.g.dart';

@Freezed()
abstract class ThreadContentDto with _$ThreadContentDto {
  const factory ThreadContentDto({
    /// Author first name
    required String authorFirstName,

    /// Author account ID
    required String authorId,

    /// Author last name
    required String authorLastName,

    /// Created timestamp
    required String createdAt,

    /// Thread ID
    required String id,

    /// Reply count
    required int replyCount,

    /// Sector IDs
    required List<dynamic>? sectorIds,

    /// Thread slug
    required String slug,

    /// Thread status
    required String status,

    /// Tag IDs
    required List<dynamic>? tagIds,

    /// Thread title
    required String title,

    /// View count
    required int viewCount,

    /// Thread description
    String? description,

    /// Updated timestamp
    String? updatedAt,
  }) = _ThreadContentDto;

  factory ThreadContentDto.fromJson(Map<String, Object?> json) =>
      _$ThreadContentDtoFromJson(json);
}
