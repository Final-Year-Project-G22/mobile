import 'package:freezed_annotation/freezed_annotation.dart';

import 'language_variant.dart';

part 'template_group_detail.freezed.dart';

@freezed
class TemplateGroupDetail with _$TemplateGroupDetail {
  const factory TemplateGroupDetail({
    required String id,
    required String name,
    required String slug,
    required String categoryId,
    required String format,
    required String tierAccess,
    required bool requiresAuth,
    required int sortOrder,
    required String defaultLanguage,
    required int downloadCount,
    @Default(<LanguageVariant>[]) List<LanguageVariant> languages,
    String? thumbnailUrl,
  }) = _TemplateGroupDetail;
}
