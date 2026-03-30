// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_detail.freezed.dart';
part 'error_detail.g.dart';

@Freezed()
abstract class ErrorDetail with _$ErrorDetail {
  const factory ErrorDetail({
    /// Where the error occurred, e.g. 'body.items[3].tags' or 'path.thing-id'
    String? location,

    /// Error message text
    String? message,

    /// The value at the given location
    dynamic value,
  }) = _ErrorDetail;

  factory ErrorDetail.fromJson(Map<String, Object?> json) => _$ErrorDetailFromJson(json);
}
