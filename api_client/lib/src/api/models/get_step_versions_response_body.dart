// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_step_versions_response_body.freezed.dart';
part 'get_step_versions_response_body.g.dart';

@Freezed()
abstract class GetStepVersionsResponseBody with _$GetStepVersionsResponseBody {
  const factory GetStepVersionsResponseBody({
    required List<dynamic>? versions,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetStepVersionsResponseBody;

  factory GetStepVersionsResponseBody.fromJson(Map<String, Object?> json) =>
      _$GetStepVersionsResponseBodyFromJson(json);
}
