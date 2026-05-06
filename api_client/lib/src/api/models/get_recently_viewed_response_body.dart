// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_recently_viewed_response_body.freezed.dart';
part 'get_recently_viewed_response_body.g.dart';

@Freezed()
abstract class GetRecentlyViewedResponseBody with _$GetRecentlyViewedResponseBody {
  const factory GetRecentlyViewedResponseBody({
    required List<dynamic>? guides,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetRecentlyViewedResponseBody;

  factory GetRecentlyViewedResponseBody.fromJson(Map<String, Object?> json) =>
      _$GetRecentlyViewedResponseBodyFromJson(json);
}
