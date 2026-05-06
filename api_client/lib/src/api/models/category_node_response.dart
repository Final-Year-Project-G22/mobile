// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_node_response.freezed.dart';
part 'category_node_response.g.dart';

@Freezed()
abstract class CategoryNodeResponse with _$CategoryNodeResponse {
  const factory CategoryNodeResponse({
    /// Category ID
    required String id,

    /// Category name
    required String name,

    /// Category slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// Child categories
    List<dynamic>? children,

    /// Icon name
    String? icon,
  }) = _CategoryNodeResponse;

  factory CategoryNodeResponse.fromJson(Map<String, Object?> json) => _$CategoryNodeResponseFromJson(json);
}
