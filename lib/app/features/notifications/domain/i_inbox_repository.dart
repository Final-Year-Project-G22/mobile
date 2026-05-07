import 'package:dartz/dartz.dart';

import 'entities/list_inbox_result.dart';
import 'failures/inbox_failure.dart';

abstract class IInboxRepository {
  Future<Either<InboxFailure, ListInboxResult>> listInbox({
    String? category,
    int? page,
    int? pageSize,
  });

  Future<Either<InboxFailure, int>> getUnreadCount();

  Future<Either<InboxFailure, Unit>> markAsRead(String id);

  Future<Either<InboxFailure, Unit>> markAllAsRead();
}
