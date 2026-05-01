// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'block_user_response_body.freezed.dart';
part 'block_user_response_body.g.dart';

@Freezed()
abstract class BlockUserResponseBody with _$BlockUserResponseBody {
  const factory BlockUserResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _BlockUserResponseBody;

  factory BlockUserResponseBody.fromJson(Map<String, Object?> json) =>
      _$BlockUserResponseBodyFromJson(json);
}
