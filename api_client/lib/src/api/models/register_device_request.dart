// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_device_request.freezed.dart';
part 'register_device_request.g.dart';

@Freezed()
abstract class RegisterDeviceRequest with _$RegisterDeviceRequest {
  const factory RegisterDeviceRequest({
    /// Device token
    required String deviceToken,

    /// Device type
    required String deviceType,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// App version
    String? appVersion,

    /// Device model
    String? deviceModel,

    /// Device name
    String? deviceName,

    /// OS version
    String? osVersion,

    /// Push notification token
    String? pushToken,
  }) = _RegisterDeviceRequest;

  factory RegisterDeviceRequest.fromJson(Map<String, Object?> json) => _$RegisterDeviceRequestFromJson(json);
}
