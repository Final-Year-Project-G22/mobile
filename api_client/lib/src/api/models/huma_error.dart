// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'huma_error.freezed.dart';
part 'huma_error.g.dart';

@Freezed()
abstract class HumaError with _$HumaError {
  const factory HumaError({
    /// Machine-readable error code
    required String code,

    /// Detailed error message
    required String detail,

    /// Short human-readable error title
    required String title,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// List of specific validation errors
    List<dynamic>? errors,
  }) = _HumaError;

  factory HumaError.fromJson(Map<String, Object?> json) => _$HumaErrorFromJson(json);
}
