// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'thread_dto.dart';

part 'get_thread_response_body.freezed.dart';
part 'get_thread_response_body.g.dart';

@Freezed()
abstract class GetThreadResponseBody with _$GetThreadResponseBody {
  const factory GetThreadResponseBody({
    /// Thread details
    required ThreadDto thread,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetThreadResponseBody;

  factory GetThreadResponseBody.fromJson(Map<String, Object?> json) => _$GetThreadResponseBodyFromJson(json);
}
