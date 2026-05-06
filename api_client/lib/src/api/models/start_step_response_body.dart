// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'start_step_response_body.freezed.dart';
part 'start_step_response_body.g.dart';

@Freezed()
abstract class StartStepResponseBody with _$StartStepResponseBody {
  const factory StartStepResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _StartStepResponseBody;

  factory StartStepResponseBody.fromJson(Map<String, Object?> json) => _$StartStepResponseBodyFromJson(json);
}
