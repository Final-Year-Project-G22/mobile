import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/failures/community_failure.dart';
import 'community_data_providers.dart';
import 'community_providers.dart';

class CommunityMutationsNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<Either<CommunityFailure, String>> createThread({
    required String categoryId,
    required String title,
    required String slug,
    required String description,
    required String initialPostContent,
    File? attachment,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.createThread(
      categoryId: categoryId,
      title: title,
      slug: slug,
      description: description,
      initialPostContent: initialPostContent,
      attachment: attachment,
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
    File? attachment,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.createPost(
      threadId: threadId,
      content: content,
      attachment: attachment,
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
    File? attachment,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.replyToPost(
      threadId: threadId,
      postId: postId,
      content: content,
      attachment: attachment,
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
    bool removeAttachment = false,
    File? attachment,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(communityRepositoryProvider);
    final result = await repo.updatePost(
      postId,
      content: content,
      removeAttachment: removeAttachment,
      attachment: attachment,
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

final communityMutationsProvider =
    AsyncNotifierProvider<CommunityMutationsNotifier, void>(
      CommunityMutationsNotifier.new,
    );
