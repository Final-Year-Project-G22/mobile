// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'subscription_response.dart';

part 'get_my_subscription_response_body.freezed.dart';
part 'get_my_subscription_response_body.g.dart';

@Freezed()
abstract class GetMySubscriptionResponseBody
    with _$GetMySubscriptionResponseBody {
  const factory GetMySubscriptionResponseBody({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Current subscription, null if none
    SubscriptionResponse? data,
  }) = _GetMySubscriptionResponseBody;

  factory GetMySubscriptionResponseBody.fromJson(Map<String, Object?> json) =>
      _$GetMySubscriptionResponseBodyFromJson(json);
}
