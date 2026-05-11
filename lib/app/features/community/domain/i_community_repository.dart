import 'package:cross_file/cross_file.dart';
import 'package:dartz/dartz.dart';

import 'entities/attachment.dart';
import 'entities/community_category.dart';
import 'entities/discussion_post.dart';
import 'entities/discussion_thread.dart';
import 'failures/community_failure.dart';

abstract class ICommunityRepository {
  Future<Either<CommunityFailure, List<DiscussionThread>>> listThreads({
    String? search,
    int? page,
    int? pageSize,
  });

  Future<Either<CommunityFailure, List<CommunityCategory>>> getCategories({
    int? page,
    int? pageSize,
    String? search,
  });

  Future<Either<CommunityFailure, List<DiscussionThread>>> searchThreads({
    String? keyword,
    int? page,
    int? pageSize,
  });

  Future<Either<CommunityFailure, DiscussionThread>> getThread(String threadId);

  Future<Either<CommunityFailure, List<DiscussionPost>>> getPosts(
    String threadId, {
    int? page,
    int? pageSize,
  });

  Future<Either<CommunityFailure, List<Attachment>>> uploadAttachments(
    List<XFile> files,
  );

  Future<Either<CommunityFailure, Unit>> deleteOrphanAttachment(String id);

  Future<Either<CommunityFailure, String>> createThread({
    required String title,
    required String slug,
    required String description,
    required String initialPostContent,
    List<String>? sectorIds,
    List<String>? tagIds,
    String? parentThreadId,
    String? attachmentIds,
  });

  Future<Either<CommunityFailure, String>> createPost({
    required String threadId,
    required String content,
    String? attachmentIds,
  });

  Future<Either<CommunityFailure, String>> replyToPost({
    required String threadId,
    required String postId,
    required String content,
    String? attachmentIds,
  });

  Future<Either<CommunityFailure, Unit>> updatePost(
    String postId, {
    required String content,
    String? attachmentIds,
    bool removeAllAttachments = false,
    String? removeAttachmentIds,
  });

  Future<Either<CommunityFailure, Unit>> deletePost(String postId);

  Future<Either<CommunityFailure, Unit>> followCategory(String categoryId);
  Future<Either<CommunityFailure, Unit>> unfollowCategory(String categoryId);

  Future<Either<CommunityFailure, Unit>> followThread(String threadId);
  Future<Either<CommunityFailure, Unit>> unfollowThread(String threadId);

  Future<Either<CommunityFailure, Unit>> markSolution(
    String threadId,
    String postId,
  );

  Future<Either<CommunityFailure, Unit>> reportPost({
    required String threadId,
    required String postId,
    required String reason,
  });

  Future<Either<CommunityFailure, Unit>> reportThread({
    required String threadId,
    required String reason,
  });

  Future<Either<CommunityFailure, Unit>> reportUser({
    required String threadId,
    required String reportedAccountId,
    required String reason,
  });
}
