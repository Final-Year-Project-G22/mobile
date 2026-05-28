// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_growth_point.freezed.dart';
part 'user_growth_point.g.dart';

@Freezed()
abstract class UserGrowthPoint with _$UserGrowthPoint {
  const factory UserGrowthPoint({
    /// Users without active subscription
    required int free,

    /// Period label (e.g. Jan, Feb)
    required String period,

    /// Users with active subscription
    required int premium,
  }) = _UserGrowthPoint;

  factory UserGrowthPoint.fromJson(Map<String, Object?> json) =>
      _$UserGrowthPointFromJson(json);
}
