import 'package:dartz/dartz.dart';

import 'entities/calendar_entry.dart';
import 'entities/compliance_entry.dart';
import 'failures/compliance_failure.dart';

abstract class IComplianceRepository {
  Future<Either<ComplianceFailure, List<ComplianceEntry>>> list({
    required String businessProfileId,
  });
  Future<Either<ComplianceFailure, ComplianceEntry>> create({
    required String businessProfileId,
    required String complianceType,
    required DateTime expiryDate,
    required int reminderDaysBefore,
    String? referenceNumber,
    DateTime? issuedDate,
  });
  Future<Either<ComplianceFailure, void>> update(
    String id, {
    String? referenceNumber,
    DateTime? expiryDate,
    int? reminderDaysBefore,
  });
  Future<Either<ComplianceFailure, void>> delete(String id);
  Future<Either<ComplianceFailure, List<CalendarEntry>>> getCalendar();
}
