// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_plans_response_body.freezed.dart';
part 'list_plans_response_body.g.dart';

@Freezed()
abstract class ListPlansResponseBody with _$ListPlansResponseBody {
  const factory ListPlansResponseBody({
    /// Available subscription plans
    required List<dynamic>? data,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListPlansResponseBody;

  factory ListPlansResponseBody.fromJson(Map<String, Object?> json) => _$ListPlansResponseBodyFromJson(json);
}
