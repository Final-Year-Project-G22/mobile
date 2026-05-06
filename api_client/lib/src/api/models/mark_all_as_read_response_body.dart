// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mark_all_as_read_response_body.freezed.dart';
part 'mark_all_as_read_response_body.g.dart';

@Freezed()
abstract class MarkAllAsReadResponseBody with _$MarkAllAsReadResponseBody {
  const factory MarkAllAsReadResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _MarkAllAsReadResponseBody;

  factory MarkAllAsReadResponseBody.fromJson(Map<String, Object?> json) => _$MarkAllAsReadResponseBodyFromJson(json);
}
