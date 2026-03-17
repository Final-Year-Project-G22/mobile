import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_failure.freezed.dart';
@freezed
abstract class AuthUserFailure with _$AuthUserFailure {
  const factory AuthUserFailure.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory AuthUserFailure.invalidEmailAndPasswordCombination() = InvalidEmailAndPasswordCombination;
  const factory AuthUserFailure.serverError() = ServerError;
  const factory AuthUserFailure.networkError() = NetworkError;
}