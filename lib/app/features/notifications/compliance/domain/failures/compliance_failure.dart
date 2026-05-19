import 'package:freezed_annotation/freezed_annotation.dart';

part 'compliance_failure.freezed.dart';

@freezed
abstract class ComplianceFailure with _$ComplianceFailure {
  const factory ComplianceFailure.unableToCreate([String? message]) = _UnableToCreate;
  const factory ComplianceFailure.unableToUpdate([String? message]) = _UnableToUpdate;
  const factory ComplianceFailure.unableToDelete([String? message]) = _UnableToDelete;
  const factory ComplianceFailure.notFound([String? message]) = _NotFound;
  const factory ComplianceFailure.serverError([String? message]) = _ServerError;
}
