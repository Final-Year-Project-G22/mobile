// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_stage_count.freezed.dart';
part 'document_stage_count.g.dart';

@Freezed()
abstract class DocumentStageCount with _$DocumentStageCount {
  const factory DocumentStageCount({
    /// Documents in this stage
    required int count,

    /// Percentage of total
    required int percentage,

    /// Pipeline stage name
    required String stage,
  }) = _DocumentStageCount;

  factory DocumentStageCount.fromJson(Map<String, Object?> json) =>
      _$DocumentStageCountFromJson(json);
}
