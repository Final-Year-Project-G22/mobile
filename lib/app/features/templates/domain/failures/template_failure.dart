import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_failure.freezed.dart';

@freezed
class TemplateFailure with _$TemplateFailure implements Exception {
  const factory TemplateFailure.networkError() = _NetworkError;
  const factory TemplateFailure.notFound() = _NotFound;
  const factory TemplateFailure.unauthorized() = _Unauthorized;
  const factory TemplateFailure.serverError([String? detail]) = _ServerError;
}
