import 'package:riverpod_annotation/riverpod_annotation.dart';

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
Future<List<DiscussionThread>> searchThreads(
  Ref ref, {
  String? keyword,
}) async {
  final repository = ref.watch(communityRepositoryProvider);
  final result = await repository.searchThreads(
    keyword: keyword,
  );

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (threads) => threads,
  );
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
