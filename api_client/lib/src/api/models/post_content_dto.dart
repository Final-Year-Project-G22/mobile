// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_content_dto.freezed.dart';
part 'post_content_dto.g.dart';

@Freezed()
abstract class PostContentDto with _$PostContentDto {
  const factory PostContentDto({
    /// Author first name
    required String authorFirstName,

    /// Author account ID
    required String authorId,

    /// Author last name
    required String authorLastName,

    /// Post content
    required String content,

    /// Created timestamp
    required String createdAt,

    /// Post ID
    required String id,

    /// Is solution
    required bool isSolution,

    /// Thread ID
    required String threadId,

    /// Parent post ID
    String? parentPostId,

    /// Thread slug
    String? threadSlug,

    /// Thread title
    String? threadTitle,

    /// Updated timestamp
    String? updatedAt,
  }) = _PostContentDto;

  factory PostContentDto.fromJson(Map<String, Object?> json) =>
      _$PostContentDtoFromJson(json);
}
