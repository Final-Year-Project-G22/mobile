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
      (attachments) => debugPrint('Mutations: upload success: ${attachments.length} files'),
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
    required String categoryId,
    required String title,
    required String slug,
    required String description,
    required String initialPostContent,
    String? attachmentIds,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.createThread(
      categoryId: categoryId,
      title: title,
      slug: slug,
      description: description,
      initialPostContent: initialPostContent,
      attachmentIds: attachmentIds,
    );

    state = const AsyncData(null);
    result.fold((_) {}, (_) {
      ref
        ..invalidate(filteredThreadsProvider)
        ..invalidate(categoryThreadsProvider);
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
}

final communityMutationsProvider = AsyncNotifierProvider<CommunityMutationsNotifier, void>(
  CommunityMutationsNotifier.new,
);
