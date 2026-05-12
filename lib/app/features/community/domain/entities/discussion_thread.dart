import 'package:freezed_annotation/freezed_annotation.dart';

part 'discussion_thread.freezed.dart';

enum ThreadStatus { open, locked, archived }

@freezed
abstract class DiscussionThread with _$DiscussionThread {
  const factory DiscussionThread({
    required String id,
    required String title,
    required String slug,
    required String authorId,
    required bool isPinned,
    required bool isFollowed,
    required int viewCount,
    required int shareCount,
    required int replyCount,
    String? authorUsername,
    String? authorDisplayName,
    String? authorAvatarUrl,
    @Default(ThreadStatus.open) ThreadStatus status,
    String? description,
    List<String>? sectorIds,
    List<String>? tagIds,
    DateTime? lastActivityAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DiscussionThread;
}
