import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';

@freezed
abstract class Tag with _$Tag {
  const factory Tag({
    required String id,
    required String slug,
    required String group,
    required String name,
    required bool isMultiSelect,
    String? description,
  }) = _Tag;
}
