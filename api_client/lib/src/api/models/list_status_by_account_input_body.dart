// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_status_by_account_input_body.freezed.dart';
part 'list_status_by_account_input_body.g.dart';

@Freezed()
abstract class ListStatusByAccountInputBody with _$ListStatusByAccountInputBody {
  const factory ListStatusByAccountInputBody({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListStatusByAccountInputBody;

  factory ListStatusByAccountInputBody.fromJson(Map<String, Object?> json) =>
      _$ListStatusByAccountInputBodyFromJson(json);
}
