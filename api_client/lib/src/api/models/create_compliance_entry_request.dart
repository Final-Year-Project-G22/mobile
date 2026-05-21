// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_compliance_entry_request.freezed.dart';
part 'create_compliance_entry_request.g.dart';

@Freezed()
abstract class CreateComplianceEntryRequest
    with _$CreateComplianceEntryRequest {
  const factory CreateComplianceEntryRequest({
    required String businessProfileId,
    required String complianceType,
    required DateTime expiryDate,
    required int reminderDaysBefore,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
    DateTime? issuedDate,
    String? referenceNumber,
  }) = _CreateComplianceEntryRequest;

  factory CreateComplianceEntryRequest.fromJson(Map<String, Object?> json) =>
      _$CreateComplianceEntryRequestFromJson(json);
}
