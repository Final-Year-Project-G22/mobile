// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_response.freezed.dart';
part 'device_response.g.dart';

@Freezed()
abstract class DeviceResponse with _$DeviceResponse {
  const factory DeviceResponse({
    /// Device token
    required String deviceToken,

    /// Device type
    required String deviceType,

    /// Device ID
    required String id,

    /// Whether the device is active
    required bool isActive,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// App version
    String? appVersion,

    /// Device model
    String? deviceModel,

    /// Device name
    String? deviceName,

    /// Last active time
    DateTime? lastActiveAt,

    /// OS version
    String? osVersion,

    /// Push notification token
    String? pushToken,
  }) = _DeviceResponse;

  factory DeviceResponse.fromJson(Map<String, Object?> json) => _$DeviceResponseFromJson(json);
}
