// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reorder_steps_response_body.freezed.dart';
part 'reorder_steps_response_body.g.dart';

@Freezed()
abstract class ReorderStepsResponseBody with _$ReorderStepsResponseBody {
  const factory ReorderStepsResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ReorderStepsResponseBody;

  factory ReorderStepsResponseBody.fromJson(Map<String, Object?> json) =>
      _$ReorderStepsResponseBodyFromJson(json);
}
