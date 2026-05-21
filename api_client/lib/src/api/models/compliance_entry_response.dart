// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'compliance_entry_response.freezed.dart';
part 'compliance_entry_response.g.dart';

@Freezed()
abstract class ComplianceEntryResponse with _$ComplianceEntryResponse {
  const factory ComplianceEntryResponse({
    required String accountId,
    required String businessProfileId,
    required String complianceType,
    required DateTime expiryDate,
    required String id,
    required int reminderDaysBefore,
    required String source,
    required String status,
    DateTime? issuedDate,
    DateTime? lastNotifiedAt,
    String? referenceNumber,
  }) = _ComplianceEntryResponse;

  factory ComplianceEntryResponse.fromJson(Map<String, Object?> json) =>
      _$ComplianceEntryResponseFromJson(json);
}
