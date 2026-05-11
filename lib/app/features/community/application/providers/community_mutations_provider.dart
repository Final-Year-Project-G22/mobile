import 'package:cross_file/cross_file.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/attachment.dart';
import '../../domain/failures/community_failure.dart';
import 'community_data_providers.dart';
import 'community_providers.dart';

class CommunityMutationsNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<Either<CommunityFailure, List<Attachment>>> uploadAttachments(
    List<XFile> files,
  ) async {
    state = const AsyncLoading();
    debugPrint(
      'Mutations: uploadAttachments called with ${files.length} files',
    );
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.uploadAttachments(files);
    result.fold(
      (failure) => debugPrint('Mutations: upload failed: $failure'),
      (attachments) =>
          debugPrint('Mutations: upload success: ${attachments.length} files'),
    );
    state = const AsyncData(null);
    return result;
  }

  Future<Either<CommunityFailure, Unit>> deleteOrphanAttachment(
    String id,
  ) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.deleteOrphanAttachment(id);
    state = const AsyncData(null);
    return result;
  }

  Future<Either<CommunityFailure, String>> createThread({
    required String title,
    required String slug,
    required String description,
    required String initialPostContent,
    List<String>? sectorIds,
    List<String>? tagIds,
    String? attachmentIds,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.createThread(
      title: title,
      slug: slug,
      description: description,
      initialPostContent: initialPostContent,
      sectorIds: sectorIds,
      tagIds: tagIds,
      attachmentIds: attachmentIds,
    );

    state = const AsyncData(null);
    result.fold((_) {}, (_) {
      ref
        ..invalidate(filteredThreadsProvider)
        ..invalidate(allThreadsProvider);
    });
    return result;
  }

  Future<Either<CommunityFailure, Unit>> updateThread({
    required String threadId,
    String? title,
    String? description,
    List<String>? sectorIds,
    List<String>? tagIds,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.updateThread(
      threadId,
      title: title,
      description: description,
      sectorIds: sectorIds,
      tagIds: tagIds,
    );

    state = const AsyncData(null);
    result.fold((_) {}, (_) {
      ref
        ..invalidate(filteredThreadsProvider)
        ..invalidate(allThreadsProvider)
        ..invalidate(threadDetailsProvider(threadId));
    });
    return result;
  }

  Future<Either<CommunityFailure, Unit>> deleteThread(
    String threadId,
  ) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.deleteThread(threadId);

    state = const AsyncData(null);
    result.fold((_) {}, (_) {
      ref
        ..invalidate(filteredThreadsProvider)
        ..invalidate(allThreadsProvider);
    });
    return result;
  }

  Future<Either<CommunityFailure, String>> createPost({
    required String threadId,
    required String content,
    String? attachmentIds,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.createPost(
      threadId: threadId,
      content: content,
      attachmentIds: attachmentIds,
    );

    state = const AsyncData(null);
    result.fold((_) {}, (_) {
      ref
        ..invalidate(threadPostsProvider(threadId))
        ..invalidate(threadDetailsProvider(threadId));
    });
    return result;
  }

  Future<Either<CommunityFailure, String>> replyToPost({
    required String threadId,
    required String postId,
    required String content,
    String? attachmentIds,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.replyToPost(
      threadId: threadId,
      postId: postId,
      content: content,
      attachmentIds: attachmentIds,
    );

    state = const AsyncData(null);
    result.fold((_) {}, (_) {
      ref
        ..invalidate(threadPostsProvider(threadId))
        ..invalidate(threadDetailsProvider(threadId));
    });
    return result;
  }

  Future<Either<CommunityFailure, Unit>> updatePost(
    String postId,
    String threadId, {
    required String content,
    String? attachmentIds,
    bool removeAllAttachments = false,
    String? removeAttachmentIds,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.updatePost(
      postId,
      content: content,
      attachmentIds: attachmentIds,
      removeAllAttachments: removeAllAttachments,
      removeAttachmentIds: removeAttachmentIds,
    );

    state = const AsyncData(null);
    result.fold((_) {}, (_) {
      ref
        ..invalidate(threadPostsProvider(threadId))
        ..invalidate(threadDetailsProvider(threadId));
    });
    return result;
  }

  Future<Either<CommunityFailure, Unit>> deletePost(
    String postId,
    String threadId,
  ) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.deletePost(postId);

    state = const AsyncData(null);
    result.fold((_) {}, (_) {
      ref
        ..invalidate(threadPostsProvider(threadId))
        ..invalidate(threadDetailsProvider(threadId));
    });
    return result;
  }

  Future<Either<CommunityFailure, Unit>> reportPost({
    required String threadId,
    required String postId,
    required String reason,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.reportPost(
      threadId: threadId,
      postId: postId,
      reason: reason,
    );
    state = const AsyncData(null);
    return result;
  }

  Future<Either<CommunityFailure, Unit>> reportThread({
    required String threadId,
    required String reason,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.reportThread(
      threadId: threadId,
      reason: reason,
    );
    state = const AsyncData(null);
    return result;
  }

  Future<Either<CommunityFailure, Unit>> reportUser({
    required String threadId,
    required String reportedAccountId,
    required String reason,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.reportUser(
      threadId: threadId,
      reportedAccountId: reportedAccountId,
      reason: reason,
    );
    state = const AsyncData(null);
    return result;
  }
}

final communityMutationsProvider =
    AsyncNotifierProvider<CommunityMutationsNotifier, void>(
      CommunityMutationsNotifier.new,
    );
