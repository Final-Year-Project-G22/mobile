import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_group.freezed.dart';

@freezed
abstract class TemplateGroup with _$TemplateGroup {
  const factory TemplateGroup({
    required String id,
    required String name,
    required String slug,
    required String categoryId,
    required String format,
    required String tierAccess,
    required int sortOrder,
    required int downloadCount,
    @Default(<String>[]) List<String> languages,
    String? thumbnailUrl,
  }) = _TemplateGroup;
}
