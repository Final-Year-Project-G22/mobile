// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mark_category_as_read_response_body.freezed.dart';
part 'mark_category_as_read_response_body.g.dart';

@Freezed()
abstract class MarkCategoryAsReadResponseBody
    with _$MarkCategoryAsReadResponseBody {
  const factory MarkCategoryAsReadResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _MarkCategoryAsReadResponseBody;

  factory MarkCategoryAsReadResponseBody.fromJson(Map<String, Object?> json) =>
      _$MarkCategoryAsReadResponseBodyFromJson(json);
}
