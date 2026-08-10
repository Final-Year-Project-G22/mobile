import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../domain/entities/scheduled_alert.dart';
import '../domain/entities/scheduled_alert_template.dart';
import '../domain/failures/scheduled_alert_failure.dart';
import '../domain/i_scheduled_alert_repository.dart';

String? _detailFromDio(DioException error) {
  final data = error.response?.data;
  if (data is Map<String, dynamic>) {
    return data['detail'] as String?;
  }
  return null;
}

class ScheduledAlertRepositoryImpl implements IScheduledAlertRepository {
  const ScheduledAlertRepositoryImpl(this._client);

  final NotificationsClient _client;

  @override
  Future<Either<ScheduledAlertFailure, List<ScheduledAlert>>> list() async {
    try {
      final response = await _client.listScheduledAlerts();
      final items = response.data.data ?? [];
      final alerts = items
          .map(
            (e) => _toAlert(
              ScheduledAlertResponse.fromJson(e as Map<String, dynamic>),
            ),
          )
          .toList();
      return Right(alerts);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(ScheduledAlertFailure.serverError());
    }
  }

  @override
  Future<Either<ScheduledAlertFailure, ScheduledAlert>> create({
    required String? templateSlug,
    required String title,
    required String body,
    required List<String> channels,
    required DateTime scheduledFor,
  }) async {
    try {
      final response = await _client.createScheduledAlert(
        body: CreateScheduledAlertRequest(
          templateSlug: templateSlug,
          title: title,
          body: body,
          channels: channels,
          scheduledFor: scheduledFor.toUtc(),
        ),
      );
      return Right(
        ScheduledAlert(
          id: response.data.id,
          title: title,
          body: body,
          channels: channels,
          scheduledFor: scheduledFor.toUtc(),
          status: 'pending',
        ),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        return Left(ScheduledAlertFailure.maxLimitReached(_detailFromDio(e)));
      }
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(ScheduledAlertFailure.serverError());
    }
  }

  @override
  Future<Either<ScheduledAlertFailure, void>> cancel(String id) async {
    try {
      await _client.cancelScheduledAlert(id: id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(ScheduledAlertFailure.serverError());
    }
  }

  @override
  Future<Either<ScheduledAlertFailure, void>> reschedule(
    String id, {
    required DateTime newScheduledFor,
  }) async {
    try {
      await _client.rescheduleScheduledAlert(
        id: id,
        body: RescheduleScheduledAlertRequest(
          scheduledFor: newScheduledFor.toUtc(),
        ),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(ScheduledAlertFailure.serverError());
    }
  }

  @override
  Future<Either<ScheduledAlertFailure, List<ScheduledAlertTemplate>>>
  listTemplates() async {
    try {
      final response = await _client.listScheduledAlertTemplates();
      final items = response.data.data ?? [];
      final templates = items
          .map(
            (e) => _toTemplate(
              ScheduledTemplateResponse.fromJson(e as Map<String, dynamic>),
            ),
          )
          .toList();
      return Right(templates);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(ScheduledAlertFailure.serverError());
    }
  }

  ScheduledAlert _toAlert(ScheduledAlertResponse dto) {
    return ScheduledAlert(
      id: dto.id,
      templateSlug: dto.templateSlug,
      title: dto.title,
      body: dto.body,
      channels: dto.channels?.cast<String>() ?? [],
      scheduledFor: dto.scheduledFor,
      status: dto.status,
      rescheduledFrom: dto.rescheduledFrom,
      sentAt: dto.sentAt,
      cancelledAt: dto.cancelledAt,
      createdAt: dto.createdAt is String
          ? DateTime.tryParse(dto.createdAt!)
          : null,
    );
  }

  ScheduledAlertTemplate _toTemplate(ScheduledTemplateResponse dto) {
    return ScheduledAlertTemplate(
      slug: dto.slug,
      name: dto.name,
      defaultTitle: dto.defaultTitle,
      defaultBody: dto.defaultBody,
      defaultChannel: dto.defaultChannel,
    );
  }

  ScheduledAlertFailure _handleDioError(DioException error) {
    final detail = _detailFromDio(error);
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return ScheduledAlertFailure.serverError(detail);
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 404) {
          return ScheduledAlertFailure.notFound(detail);
        }
        return ScheduledAlertFailure.serverError(detail);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return ScheduledAlertFailure.serverError(detail);
    }
  }
}
