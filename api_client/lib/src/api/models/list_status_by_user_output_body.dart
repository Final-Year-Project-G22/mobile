// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_status_by_user_output_body.freezed.dart';
part 'list_status_by_user_output_body.g.dart';

@Freezed()
abstract class ListStatusByUserOutputBody with _$ListStatusByUserOutputBody {
  const factory ListStatusByUserOutputBody({
    /// List of status projections
    required List<dynamic>? projections,

    /// Total count for pagination
    required int total,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListStatusByUserOutputBody;

  factory ListStatusByUserOutputBody.fromJson(Map<String, Object?> json) => _$ListStatusByUserOutputBodyFromJson(json);
}
