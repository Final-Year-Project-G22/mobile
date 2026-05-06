// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_thread_response_body.freezed.dart';
part 'create_thread_response_body.g.dart';

@Freezed()
abstract class CreateThreadResponseBody with _$CreateThreadResponseBody {
  const factory CreateThreadResponseBody({
    /// Initial post ID
    required String postId,

    /// Created thread ID
    required String threadId,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _CreateThreadResponseBody;

  factory CreateThreadResponseBody.fromJson(Map<String, Object?> json) => _$CreateThreadResponseBodyFromJson(json);
}
