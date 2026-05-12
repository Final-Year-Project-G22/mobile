// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'revert_step_to_version_response_body.freezed.dart';
part 'revert_step_to_version_response_body.g.dart';

@Freezed()
abstract class RevertStepToVersionResponseBody
    with _$RevertStepToVersionResponseBody {
  const factory RevertStepToVersionResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _RevertStepToVersionResponseBody;

  factory RevertStepToVersionResponseBody.fromJson(Map<String, Object?> json) =>
      _$RevertStepToVersionResponseBodyFromJson(json);
}
