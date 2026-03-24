import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_failure.freezed.dart';

@freezed
abstract class AuthUserFailure with _$AuthUserFailure {
  const factory AuthUserFailure.emailAlreadyInUse({String? message}) = EmailAlreadyInUse;
  const factory AuthUserFailure.invalidEmailAndPasswordCombination({String? message}) =
      InvalidEmailAndPasswordCombination;
  const factory AuthUserFailure.serverError({String? message}) = ServerError;
  const factory AuthUserFailure.networkError({String? message}) = NetworkError;
}
