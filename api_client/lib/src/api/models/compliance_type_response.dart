// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'compliance_type_response.freezed.dart';
part 'compliance_type_response.g.dart';

@Freezed()
abstract class ComplianceTypeResponse with _$ComplianceTypeResponse {
  const factory ComplianceTypeResponse({
    required String label,
    required String slug,
  }) = _ComplianceTypeResponse;

  factory ComplianceTypeResponse.fromJson(Map<String, Object?> json) =>
      _$ComplianceTypeResponseFromJson(json);
}
