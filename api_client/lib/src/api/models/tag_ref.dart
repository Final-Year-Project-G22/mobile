// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_ref.freezed.dart';
part 'tag_ref.g.dart';

@Freezed()
abstract class TagRef with _$TagRef {
  const factory TagRef({
    /// Tag group
    required String group,

    /// Tag identifier
    required String id,

    /// Whether the tag allows multiple selections
    required bool isMultiSelect,

    /// Tag slug
    required String slug,
  }) = _TagRef;

  factory TagRef.fromJson(Map<String, Object?> json) => _$TagRefFromJson(json);
}
