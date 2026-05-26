// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread_dto.freezed.dart';
part 'thread_dto.g.dart';

@Freezed()
abstract class ThreadDto with _$ThreadDto {
  const factory ThreadDto({
    /// Author display name
    required String authorDisplayName,

    /// Author account ID
    required String authorId,

    /// Whether thread has an accepted solution
    required bool hasSolution,

    /// Thread ID
    required String id,

    /// Whether current user follows this thread
    required bool isFollowed,

    /// Whether current user has muted this thread
    required bool isMuted,

    /// Pinned flag
    required bool isPinned,

    /// Reply count
    required int replyCount,

    /// Sector IDs
    required List<dynamic>? sectorIds,

    /// Share count
    required int shareCount,

    /// Thread slug
    required String slug,

    /// Thread status
    required String status,

    /// Tag IDs
    required List<dynamic>? tagIds,

    /// Thread title
    required String title,

    /// Number of unread posts/replies
    required int unreadCount,

    /// View count
    required int viewCount,

    /// Author avatar URL
    String? authorAvatarUrl,

    /// Author username
    String? authorUsername,

    /// Created timestamp
    DateTime? createdAt,

    /// Thread description
    String? description,

    /// Last activity timestamp
    DateTime? lastActivityAt,

    /// Parent thread ID for sub-threads
    String? parentThreadId,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _ThreadDto;

  factory ThreadDto.fromJson(Map<String, Object?> json) =>
      _$ThreadDtoFromJson(json);
}
