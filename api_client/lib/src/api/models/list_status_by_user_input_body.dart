// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_status_by_user_input_body.freezed.dart';
part 'list_status_by_user_input_body.g.dart';

@Freezed()
abstract class ListStatusByUserInputBody with _$ListStatusByUserInputBody {
  const factory ListStatusByUserInputBody({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListStatusByUserInputBody;

  factory ListStatusByUserInputBody.fromJson(Map<String, Object?> json) =>
      _$ListStatusByUserInputBodyFromJson(json);
}
