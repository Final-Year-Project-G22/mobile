import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../failures/template_failure.dart';
import 'language_variant.dart';

part 'template_group_detail.freezed.dart';

@freezed
abstract class TemplateGroupDetail with _$TemplateGroupDetail {
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

  const TemplateGroupDetail._();

  Option<TemplateFailure> get failureOption {
    if (languages.isEmpty) return some(const TemplateFailure.invalidData());
    return none();
  }
}
