import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_value_failure.freezed.dart';

@freezed
abstract class ProfileValueFailure<T> with _$ProfileValueFailure<T> {
  const factory ProfileValueFailure.emptyField({
    required T failedValue,
    required String fieldName,
  }) = EmptyField<T>;

  const factory ProfileValueFailure.invalidFirstName({required T failedValue}) = InvalidFirstName<T>;

  const factory ProfileValueFailure.invalidLastName({required T failedValue}) = InvalidLastName<T>;

  const factory ProfileValueFailure.shortName({
    required T failedValue,
    required String fieldName,
  }) = ShortName<T>;
}
