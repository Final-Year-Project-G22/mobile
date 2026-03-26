import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_failure.freezed.dart';

@freezed
abstract class ProfileFailure with _$ProfileFailure {
  const factory ProfileFailure.unableToUpdate() = _UnableToUpdate;
  const factory ProfileFailure.serverError() = _ServerError;
  const factory ProfileFailure.unableToUpload() = _UnableToUpload;
  const factory ProfileFailure.invalidProfileData() = _InvalidProfileData;
}
