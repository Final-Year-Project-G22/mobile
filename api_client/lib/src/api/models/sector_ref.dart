// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sector_ref.freezed.dart';
part 'sector_ref.g.dart';

@Freezed()
abstract class SectorRef with _$SectorRef {
  const factory SectorRef({
    /// Sector identifier
    required String id,

    /// Sector slug
    required String slug,
  }) = _SectorRef;

  factory SectorRef.fromJson(Map<String, Object?> json) => _$SectorRefFromJson(json);
}
