// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_model.freezed.dart';
part 'error_model.g.dart';

@Freezed()
abstract class ErrorModel with _$ErrorModel {
  const factory ErrorModel({
    /// A URI reference to human-readable documentation for the error.
    @Default('about:blank') String type,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// A human-readable explanation specific to this occurrence of the problem.
    String? detail,

    /// Optional list of individual error details
    List<dynamic>? errors,

    /// A URI reference that identifies the specific occurrence of the problem.
    String? instance,

    /// HTTP status code
    int? status,

    /// A short, human-readable summary of the problem type. This value should not change between occurrences of the error.
    String? title,
  }) = _ErrorModel;

  factory ErrorModel.fromJson(Map<String, Object?> json) => _$ErrorModelFromJson(json);
}
