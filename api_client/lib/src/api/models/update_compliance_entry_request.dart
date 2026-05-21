// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_compliance_entry_request.freezed.dart';
part 'update_compliance_entry_request.g.dart';

@Freezed()
abstract class UpdateComplianceEntryRequest
    with _$UpdateComplianceEntryRequest {
  const factory UpdateComplianceEntryRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
    DateTime? expiryDate,
    DateTime? issuedDate,
    String? referenceNumber,
    int? reminderDaysBefore,
    String? status,
  }) = _UpdateComplianceEntryRequest;

  factory UpdateComplianceEntryRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateComplianceEntryRequestFromJson(json);
}
