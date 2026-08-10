import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../domain/entities/calendar_entry.dart';
import '../domain/entities/compliance_entry.dart';
import '../domain/failures/compliance_failure.dart';
import '../domain/i_compliance_repository.dart';

class ComplianceRepositoryImpl implements IComplianceRepository {
  const ComplianceRepositoryImpl(this._client);

  final ComplianceClient _client;

  @override
  Future<Either<ComplianceFailure, List<ComplianceEntry>>> list({
    required String businessProfileId,
  }) async {
    try {
      final response = await _client.listComplianceEntries(
        businessProfileId: businessProfileId,
      );
      final items = response.data.data ?? [];
      final entries = items
          .map(
            (e) => _toEntry(
              ComplianceEntryResponse.fromJson(e as Map<String, dynamic>),
            ),
          )
          .toList();
      return Right(entries);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(ComplianceFailure.serverError());
    }
  }

  @override
  Future<Either<ComplianceFailure, ComplianceEntry>> create({
    required String businessProfileId,
    required String complianceType,
    required DateTime expiryDate,
    required int reminderDaysBefore,
    String? referenceNumber,
    DateTime? issuedDate,
  }) async {
    try {
      final response = await _client.createComplianceEntry(
        body: CreateComplianceEntryRequest(
          businessProfileId: businessProfileId,
          complianceType: complianceType,
          referenceNumber: referenceNumber,
          issuedDate: issuedDate,
          expiryDate: expiryDate.toUtc(),
          reminderDaysBefore: reminderDaysBefore,
        ),
      );
      return Right(
        ComplianceEntry(
          id: response.data.id,
          businessProfileId: businessProfileId,
          accountId: '',
          complianceType: complianceType,
          expiryDate: expiryDate.toUtc(),
          reminderDaysBefore: reminderDaysBefore,
          status: 'active',
          referenceNumber: referenceNumber,
          issuedDate: issuedDate,
        ),
      );
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(ComplianceFailure.serverError());
    }
  }

  @override
  Future<Either<ComplianceFailure, void>> update(
    String id, {
    String? referenceNumber,
    DateTime? expiryDate,
    int? reminderDaysBefore,
  }) async {
    try {
      await _client.updateComplianceEntry(
        id: id,
        body: UpdateComplianceEntryRequest(
          referenceNumber: referenceNumber,
          expiryDate: expiryDate,
          reminderDaysBefore: reminderDaysBefore,
        ),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(ComplianceFailure.serverError());
    }
  }

  @override
  Future<Either<ComplianceFailure, void>> delete(String id) async {
    try {
      await _client.deleteComplianceEntry(id: id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(ComplianceFailure.serverError());
    }
  }

  @override
  Future<Either<ComplianceFailure, List<CalendarEntry>>> getCalendar() async {
    try {
      final response = await _client.getComplianceCalendar();
      final items = response.data.entries ?? [];
      final entries = items
          .map(
            (e) => _toCalendarEntry(
              CalendarEntryResponse.fromJson(e as Map<String, dynamic>),
            ),
          )
          .toList();
      return Right(entries);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(ComplianceFailure.serverError());
    }
  }

  ComplianceEntry _toEntry(ComplianceEntryResponse dto) {
    return ComplianceEntry(
      id: dto.id,
      businessProfileId: dto.businessProfileId,
      accountId: dto.accountId,
      complianceType: dto.complianceType,
      expiryDate: dto.expiryDate,
      reminderDaysBefore: dto.reminderDaysBefore,
      status: dto.status,
      source: dto.source,
      referenceNumber: dto.referenceNumber,
      issuedDate: dto.issuedDate,
      lastNotifiedAt: dto.lastNotifiedAt,
    );
  }

  CalendarEntry _toCalendarEntry(CalendarEntryResponse dto) {
    return CalendarEntry(
      id: dto.id,
      type: dto.type,
      title: dto.title,
      date: dto.date,
      daysRemaining: dto.daysRemaining,
      status: dto.status,
      referenceNumber: dto.referenceNumber,
    );
  }

  String? _detailFromDio(DioException error) {
    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      return data['detail'] as String?;
    }
    return null;
  }

  ComplianceFailure _handleDioError(DioException error) {
    final detail = _detailFromDio(error);
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return ComplianceFailure.serverError(detail);
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 404) {
          return ComplianceFailure.notFound(detail);
        }
        return ComplianceFailure.serverError(detail);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return ComplianceFailure.serverError(detail);
    }
  }
}
