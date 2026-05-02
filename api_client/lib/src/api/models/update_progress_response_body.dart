// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_progress_response_body.freezed.dart';
part 'update_progress_response_body.g.dart';

@Freezed()
abstract class UpdateProgressResponseBody with _$UpdateProgressResponseBody {
  const factory UpdateProgressResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateProgressResponseBody;

  factory UpdateProgressResponseBody.fromJson(Map<String, Object?> json) =>
      _$UpdateProgressResponseBodyFromJson(json);
}
