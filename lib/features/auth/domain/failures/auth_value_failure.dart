import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_value_failure.freezed.dart';

@freezed
abstract class AuthValueFailure<T> with _$AuthValueFailure<T> {
  const factory AuthValueFailure.emptyField({
    required T failedValue,
    required String fieldName,
  }) = EmptyField<T>;

  const factory AuthValueFailure.invalidEmail({
    required T failedValue,
  }) = InvalidEmail<T>;

  const factory AuthValueFailure.invalidPassword({
    required T failedValue,
  }) = InvalidPassword<T>;

  const factory AuthValueFailure.invalidFirstName({
    required T failedValue,
  }) = InvalidFirstName<T>;

  const factory AuthValueFailure.invalidLastName({
    required T failedValue,
  }) = InvalidLastName<T>;

  const factory AuthValueFailure.shortName({
    required T failedValue,
    required String fieldName,
  }) = ShortName<T>;
}