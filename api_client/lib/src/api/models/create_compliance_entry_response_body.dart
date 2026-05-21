// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_compliance_entry_response_body.freezed.dart';
part 'create_compliance_entry_response_body.g.dart';

@Freezed()
abstract class CreateComplianceEntryResponseBody
    with _$CreateComplianceEntryResponseBody {
  const factory CreateComplianceEntryResponseBody({
    required String id,
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _CreateComplianceEntryResponseBody;

  factory CreateComplianceEntryResponseBody.fromJson(
    Map<String, Object?> json,
  ) => _$CreateComplianceEntryResponseBodyFromJson(json);
}
