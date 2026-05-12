// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

@Freezed()
abstract class PostDto with _$PostDto {
  const factory PostDto({
    /// Author display name
    required String authorDisplayName,

    /// Author account ID
    required String authorId,

    /// Post content
    required String content,

    /// Edit count
    required int editCount,

    /// Post ID
    required String id,

    /// Pinned flag
    required bool isPinned,

    /// Solution flag
    required bool isSolution,

    /// Thread ID
    required String threadId,

    /// Upvote count
    required int upvoteCount,

    /// Post attachments
    List<dynamic>? attachments,

    /// Author avatar URL
    String? authorAvatarUrl,

    /// Author username
    String? authorUsername,

    /// Created timestamp
    DateTime? createdAt,

    /// Edited timestamp
    DateTime? editedAt,

    /// Parent post ID
    String? parentPostId,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _PostDto;

  factory PostDto.fromJson(Map<String, Object?> json) => _$PostDtoFromJson(json);
}
