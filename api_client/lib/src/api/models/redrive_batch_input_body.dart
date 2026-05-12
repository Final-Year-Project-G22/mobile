// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'redrive_batch_input_body.freezed.dart';
part 'redrive_batch_input_body.g.dart';

@Freezed()
abstract class RedriveBatchInputBody with _$RedriveBatchInputBody {
  const factory RedriveBatchInputBody({
    required List<dynamic>? eventIds,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _RedriveBatchInputBody;

  factory RedriveBatchInputBody.fromJson(Map<String, Object?> json) => _$RedriveBatchInputBodyFromJson(json);
}
