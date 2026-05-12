// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'unmute_account_response_body.freezed.dart';
part 'unmute_account_response_body.g.dart';

@Freezed()
abstract class UnmuteAccountResponseBody with _$UnmuteAccountResponseBody {
  const factory UnmuteAccountResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UnmuteAccountResponseBody;

  factory UnmuteAccountResponseBody.fromJson(Map<String, Object?> json) =>
      _$UnmuteAccountResponseBodyFromJson(json);
}
