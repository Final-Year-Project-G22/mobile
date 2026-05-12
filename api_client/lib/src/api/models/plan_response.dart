// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_response.freezed.dart';
part 'plan_response.g.dart';

@Freezed()
abstract class PlanResponse with _$PlanResponse {
  const factory PlanResponse({
    /// Amount in minor units
    required int amount,

    /// Currency code
    required String currency,

    /// Plan ID
    required String id,

    /// Whether plan is available
    required bool isActive,

    /// Plan name
    required String name,

    /// Billing period
    required String period,
  }) = _PlanResponse;

  factory PlanResponse.fromJson(Map<String, Object?> json) => _$PlanResponseFromJson(json);
}
