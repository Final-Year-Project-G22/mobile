// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_compliance_types_response_body.freezed.dart';
part 'list_compliance_types_response_body.g.dart';

@Freezed()
abstract class ListComplianceTypesResponseBody
    with _$ListComplianceTypesResponseBody {
  const factory ListComplianceTypesResponseBody({
    required List<dynamic>? data,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListComplianceTypesResponseBody;

  factory ListComplianceTypesResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListComplianceTypesResponseBodyFromJson(json);
}
