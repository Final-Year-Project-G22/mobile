import 'package:freezed_annotation/freezed_annotation.dart';

import 'attachment.dart';

part 'discussion_post.freezed.dart';

@freezed
abstract class DiscussionPost with _$DiscussionPost {
  const factory DiscussionPost({
    required String id,
    required String threadId,
    required String authorId,
    required String content,
    required bool isSolution,
    required bool isPinned,
    required int upvoteCount,
    required int editCount,
    String? authorUsername,
    String? authorDisplayName,
    String? authorAvatarUrl,
    String? parentPostId,
    List<Attachment>? attachments,
    DateTime? editedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DiscussionPost;
}
