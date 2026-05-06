// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'redrive_batch_output_body.freezed.dart';
part 'redrive_batch_output_body.g.dart';

@Freezed()
abstract class RedriveBatchOutputBody with _$RedriveBatchOutputBody {
  const factory RedriveBatchOutputBody({
    required int successCount,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _RedriveBatchOutputBody;

  factory RedriveBatchOutputBody.fromJson(Map<String, Object?> json) => _$RedriveBatchOutputBodyFromJson(json);
}
