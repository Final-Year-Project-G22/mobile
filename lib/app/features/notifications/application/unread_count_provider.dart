import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/inbox_providers.dart';

part 'unread_count_provider.g.dart';

@riverpod
Future<int> unreadCount(Ref ref) async {
  final repository = ref.watch(inboxRepositoryProvider);
  final result = await repository.getUnreadCount();

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (count) => count,
  );
}
