import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_variant.freezed.dart';

@freezed
class LanguageVariant with _$LanguageVariant {
  const factory LanguageVariant({
    required String language,
    required String title,
    required String contentType,
    required int fileSize,
    required int version,
    String? description,
  }) = _LanguageVariant;
}
