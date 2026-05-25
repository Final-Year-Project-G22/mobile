// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_global_preference_request.freezed.dart';
part 'update_global_preference_request.g.dart';

@Freezed()
abstract class UpdateGlobalPreferenceRequest
    with _$UpdateGlobalPreferenceRequest {
  const factory UpdateGlobalPreferenceRequest({
    bool? emailEnabled,
    bool? pushEnabled,
  }) = _UpdateGlobalPreferenceRequest;

  factory UpdateGlobalPreferenceRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateGlobalPreferenceRequestFromJson(json);
}
