import 'package:freezed_annotation/freezed_annotation.dart';

part 'compliance_entry.freezed.dart';

@freezed
abstract class ComplianceEntry with _$ComplianceEntry {
  const factory ComplianceEntry({
    required String id,
    required String businessProfileId,
    required String accountId,
    required String complianceType,
    required DateTime expiryDate,
    required int reminderDaysBefore,
    required String status,
    @Default('manual') String source,
    String? referenceNumber,
    DateTime? issuedDate,
    DateTime? lastNotifiedAt,
  }) = _ComplianceEntry;
}
