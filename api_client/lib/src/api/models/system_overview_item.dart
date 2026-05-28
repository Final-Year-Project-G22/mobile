// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_overview_item.freezed.dart';
part 'system_overview_item.g.dart';

@Freezed()
abstract class SystemOverviewItem with _$SystemOverviewItem {
  const factory SystemOverviewItem({
    /// Item label
    required String label,

    /// Indicator type: success, warning, danger
    required String type,

    /// Item value
    required String value,
  }) = _SystemOverviewItem;

  factory SystemOverviewItem.fromJson(Map<String, Object?> json) =>
      _$SystemOverviewItemFromJson(json);
}
