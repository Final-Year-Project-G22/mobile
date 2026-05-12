import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/providers/websocket_providers.dart';
import '../../domain/entities/discussion_post.dart';
import '../../domain/entities/discussion_thread.dart';
import 'community_providers.dart';
import 'community_state_providers.dart';

part 'community_data_providers.g.dart';

@riverpod
Future<List<DiscussionThread>> filteredThreads(Ref ref) async {
  final searchText = ref.watch(searchTextProvider);
  final repository = ref.watch(communityRepositoryProvider);

  final result = await repository.listThreads(
    search: (searchText != null && searchText.isNotEmpty) ? searchText : null,
  );

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (threads) => threads,
  );
}

@riverpod
Future<List<DiscussionThread>> allThreads(Ref ref) async {
  final searchText = ref.watch(searchTextProvider);
  final repository = ref.watch(communityRepositoryProvider);

  final result = await repository.listAllThreads(
    search: (searchText != null && searchText.isNotEmpty) ? searchText : null,
  );

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (threads) => threads,
  );
}

@riverpod
Future<List<DiscussionThread>> filteredAllThreads(Ref ref) async {
  final threads = await ref.watch(allThreadsProvider.future);
  final selectedSectors = ref.watch(selectedSectorIdsProvider);
  final selectedTags = ref.watch(selectedTagIdsProvider);
  final showFollowed = ref.watch(showFollowedOnlyProvider);

  return threads.where((t) {
    if (selectedSectors.isNotEmpty &&
        !(t.sectorIds?.any(selectedSectors.contains) ?? false)) {
      return false;
    }
    if (selectedTags.isNotEmpty &&
        !(t.tagIds?.any(selectedTags.contains) ?? false)) {
      return false;
    }
    if (showFollowed && !t.isFollowed) {
      return false;
    }
    return true;
  }).toList();
}

@riverpod
Future<DiscussionThread> threadDetails(
  Ref ref,
  String threadId,
) async {
  final repository = ref.watch(communityRepositoryProvider);
  final result = await repository.getThread(threadId);

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (thread) => thread,
  );
}

@riverpod
Future<List<DiscussionPost>> threadPosts(
  Ref ref,
  String threadId,
) async {
  final repository = ref.watch(communityRepositoryProvider);
  final result = await repository.getPosts(threadId);

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (posts) => posts,
  );
}

@riverpod
void communityWsListener(Ref ref) {
  ref.listen(wsMessagesProvider, (_, next) {
    final msg = next.asData?.value;
    if (msg == null) return;

    final type = msg['type'] as String?;
    final threadId = msg['threadId'] as String?;
    if (threadId == null) return;

    if (type == 'post.created') {
      ref
        ..invalidate(threadPostsProvider(threadId))
        ..invalidate(threadDetailsProvider(threadId))
        ..invalidate(filteredThreadsProvider)
        ..invalidate(allThreadsProvider);
    }
    if (type == 'thread.updated') {
      ref
        ..invalidate(threadDetailsProvider(threadId))
        ..invalidate(filteredThreadsProvider)
        ..invalidate(allThreadsProvider);
    }
  });
}
