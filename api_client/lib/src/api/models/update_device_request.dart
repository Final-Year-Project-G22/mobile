// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_device_request.freezed.dart';
part 'update_device_request.g.dart';

@Freezed()
abstract class UpdateDeviceRequest with _$UpdateDeviceRequest {
  const factory UpdateDeviceRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// App version
    String? appVersion,

    /// Device name
    String? deviceName,

    /// Whether the device is active
    bool? isActive,

    /// OS version
    String? osVersion,

    /// Push notification token
    String? pushToken,
  }) = _UpdateDeviceRequest;

  factory UpdateDeviceRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateDeviceRequestFromJson(json);
}
