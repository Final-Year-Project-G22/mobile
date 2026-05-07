import 'package:api_client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/features/notifications/domain/i_inbox_repository.dart';
import '../../app/features/notifications/infrastructure/inbox_repository_impl.dart';
import 'infra_providers.dart';

part 'inbox_providers.g.dart';

@riverpod
IInboxRepository inboxRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return InboxRepositoryImpl(NotificationsClient(apiClient.dio));
}
