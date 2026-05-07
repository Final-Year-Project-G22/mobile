import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../domain/entities/inbox_entry.dart';
import '../domain/entities/list_inbox_result.dart';
import '../domain/entities/notification_summary.dart';
import '../domain/failures/inbox_failure.dart';
import '../domain/i_inbox_repository.dart';

class InboxRepositoryImpl implements IInboxRepository {
  const InboxRepositoryImpl(this._client);

  final NotificationsClient _client;

  @override
  Future<Either<InboxFailure, ListInboxResult>> listInbox({
    String? category,
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await _client.listInbox(
        category: category,
        page: page,
        pageSize: pageSize,
      );

      final entries = (response.data.data ?? [])
          .map((e) => _mapInboxEntry(InboxEntryResponse.fromJson(e as Map<String, dynamic>)))
          .toList();

      return Right(
        ListInboxResult(
          entries: entries,
          page: response.data.page,
          totalPages: response.data.totalPages,
          total: response.data.total,
          pageSize: response.data.pageSize,
        ),
      );
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(InboxFailure.serverError());
    }
  }

  @override
  Future<Either<InboxFailure, int>> getUnreadCount() async {
    try {
      final response = await _client.getUnreadCount();
      return Right(response.data.count);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(InboxFailure.serverError());
    }
  }

  @override
  Future<Either<InboxFailure, Unit>> markAsRead(String id) async {
    try {
      await _client.markAsRead(id: id);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(InboxFailure.serverError());
    }
  }

  @override
  Future<Either<InboxFailure, Unit>> markAllAsRead() async {
    try {
      await _client.markAllAsRead();
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(InboxFailure.serverError());
    }
  }

  InboxEntry _mapInboxEntry(InboxEntryResponse dto) {
    return InboxEntry(
      id: dto.id,
      category: dto.category,
      isRead: dto.isRead,
      isArchived: dto.isArchived,
      actionUrl: dto.actionUrl,
      expiresAt: dto.expiresAt,
      notification: _mapNotification(dto.notification),
    );
  }

  NotificationSummary _mapNotification(NotificationSummaryResponse dto) {
    return NotificationSummary(
      type: dto.notificationType,
      channel: dto.channel,
      title: dto.title,
      content: dto.content,
      sentAt: dto.sentAt,
      deliveredAt: dto.deliveredAt,
      readAt: dto.readAt,
    );
  }

  InboxFailure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const InboxFailure.networkError();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        final detail = data is Map<String, dynamic> ? data['detail'] as String? : null;

        if (statusCode == 404) {
          return const InboxFailure.notFound();
        } else if (statusCode == 401 || statusCode == 403) {
          return const InboxFailure.unauthorized();
        } else if (statusCode == 400 || statusCode == 422) {
          return InboxFailure.invalidData(detail);
        }
        return InboxFailure.serverError(detail);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const InboxFailure.serverError();
    }
  }
}
