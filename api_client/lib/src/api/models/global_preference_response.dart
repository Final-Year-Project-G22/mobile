// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_preference_response.freezed.dart';
part 'global_preference_response.g.dart';

@Freezed()
abstract class GlobalPreferenceResponse with _$GlobalPreferenceResponse {
  const factory GlobalPreferenceResponse({
    required bool emailEnabled,
    required bool pushEnabled,
  }) = _GlobalPreferenceResponse;

  factory GlobalPreferenceResponse.fromJson(Map<String, Object?> json) =>
      _$GlobalPreferenceResponseFromJson(json);
}
