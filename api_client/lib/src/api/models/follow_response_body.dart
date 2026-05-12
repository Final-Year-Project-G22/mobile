// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'follow_response_body.freezed.dart';
part 'follow_response_body.g.dart';

@Freezed()
abstract class FollowResponseBody with _$FollowResponseBody {
  const factory FollowResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _FollowResponseBody;

  factory FollowResponseBody.fromJson(Map<String, Object?> json) => _$FollowResponseBodyFromJson(json);
}
