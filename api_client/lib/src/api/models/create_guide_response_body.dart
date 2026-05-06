// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_guide_response_body.freezed.dart';
part 'create_guide_response_body.g.dart';

@Freezed()
abstract class CreateGuideResponseBody with _$CreateGuideResponseBody {
  const factory CreateGuideResponseBody({
    /// Created guide ID
    required String id,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _CreateGuideResponseBody;

  factory CreateGuideResponseBody.fromJson(Map<String, Object?> json) => _$CreateGuideResponseBodyFromJson(json);
}
