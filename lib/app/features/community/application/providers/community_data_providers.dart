import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/community_category.dart';
import '../../domain/entities/discussion_post.dart';
import '../../domain/entities/discussion_thread.dart';
import 'community_providers.dart';
import 'community_state_providers.dart';

part 'community_data_providers.g.dart';

@riverpod
Future<List<CommunityCategory>> categories(Ref ref) async {
  final repository = ref.watch(communityRepositoryProvider);
  final result = await repository.getCategories();

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (categories) => categories,
  );
}

@riverpod
Future<List<DiscussionThread>> filteredThreads(Ref ref) async {
  final searchText = ref.watch(searchTextProvider);
  final categoryId = ref.watch(selectedCategoryIdProvider);
  final repository = ref.watch(communityRepositoryProvider);

  final result = await repository.listThreads(
    categoryId: categoryId,
    search: (searchText != null && searchText.isNotEmpty) ? searchText : null,
  );

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (threads) => threads,
  );
}

@riverpod
Future<List<DiscussionThread>> categoryThreads(
  Ref ref,
  String categoryId,
) async {
  final repository = ref.watch(communityRepositoryProvider);
  final result = await repository.listThreads(categoryId: categoryId);

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (threads) => threads,
  );
}

@riverpod
Future<List<DiscussionThread>> searchThreads(
  Ref ref, {
  String? keyword,
  String? categoryId,
}) async {
  final repository = ref.watch(communityRepositoryProvider);
  final result = await repository.listThreads(
    search: keyword,
    categoryId: categoryId,
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
