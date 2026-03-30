// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'account_dto.dart';
import 'user_dto.dart';

part 'get_current_user_response_body.freezed.dart';
part 'get_current_user_response_body.g.dart';

@Freezed()
abstract class GetCurrentUserResponseBody with _$GetCurrentUserResponseBody {
  const factory GetCurrentUserResponseBody({
    /// Current user account
    required AccountDto account,

    /// Current user
    required UserDto user,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetCurrentUserResponseBody;

  factory GetCurrentUserResponseBody.fromJson(Map<String, Object?> json) =>
      _$GetCurrentUserResponseBodyFromJson(json);
}
