import 'package:freezed_annotation/freezed_annotation.dart';

part 'sector.freezed.dart';

@freezed
abstract class Sector with _$Sector {
  const factory Sector({
    required String id,
    required String slug,
    required String name,
    String? description,
    String? parentId,
  }) = _Sector;
}
