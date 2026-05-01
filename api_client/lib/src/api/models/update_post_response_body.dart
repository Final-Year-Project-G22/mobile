// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_post_response_body.freezed.dart';
part 'update_post_response_body.g.dart';

@Freezed()
abstract class UpdatePostResponseBody with _$UpdatePostResponseBody {
  const factory UpdatePostResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdatePostResponseBody;

  factory UpdatePostResponseBody.fromJson(Map<String, Object?> json) =>
      _$UpdatePostResponseBodyFromJson(json);
}
