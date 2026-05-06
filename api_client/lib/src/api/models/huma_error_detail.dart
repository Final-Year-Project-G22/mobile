// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'huma_error_detail.freezed.dart';
part 'huma_error_detail.g.dart';

@Freezed()
abstract class HumaErrorDetail with _$HumaErrorDetail {
  const factory HumaErrorDetail({
    /// Human-readable error message
    required String message,

    /// Where the error occurred (e.g., 'body.email')
    String? location,

    /// The value that caused the error
    dynamic value,
  }) = _HumaErrorDetail;

  factory HumaErrorDetail.fromJson(Map<String, Object?> json) => _$HumaErrorDetailFromJson(json);
}
