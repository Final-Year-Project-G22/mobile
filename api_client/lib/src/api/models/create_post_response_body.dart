// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_response_body.freezed.dart';
part 'create_post_response_body.g.dart';

@Freezed()
abstract class CreatePostResponseBody with _$CreatePostResponseBody {
  const factory CreatePostResponseBody({
    /// Created post ID
    required String postId,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _CreatePostResponseBody;

  factory CreatePostResponseBody.fromJson(Map<String, Object?> json) =>
      _$CreatePostResponseBodyFromJson(json);
}
