import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/conversation_summary.dart';
import 'ai_providers.dart';

part 'ai_conversation_list_provider.g.dart';

@riverpod
Future<List<ConversationSummary>> aiConversationList(Ref ref) async {
  final repository = ref.watch(aiRepositoryProvider);
  final result = await repository.listConversations();

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (conversations) => conversations,
  );
}
