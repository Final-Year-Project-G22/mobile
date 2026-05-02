// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_summary_response.freezed.dart';
part 'category_summary_response.g.dart';

@Freezed()
abstract class CategorySummaryResponse with _$CategorySummaryResponse {
  const factory CategorySummaryResponse({
    /// Category ID
    required String id,

    /// Active flag
    required bool isActive,

    /// Category name
    required String name,

    /// Category slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// Icon name
    String? icon,
  }) = _CategorySummaryResponse;

  factory CategorySummaryResponse.fromJson(Map<String, Object?> json) =>
      _$CategorySummaryResponseFromJson(json);
}
