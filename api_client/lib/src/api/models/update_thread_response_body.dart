// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_thread_response_body.freezed.dart';
part 'update_thread_response_body.g.dart';

@Freezed()
abstract class UpdateThreadResponseBody with _$UpdateThreadResponseBody {
  const factory UpdateThreadResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateThreadResponseBody;

  factory UpdateThreadResponseBody.fromJson(Map<String, Object?> json) =>
      _$UpdateThreadResponseBodyFromJson(json);
}
