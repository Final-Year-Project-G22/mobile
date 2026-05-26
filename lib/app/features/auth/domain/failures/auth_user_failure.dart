import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_failure.freezed.dart';

@freezed
abstract class AuthUserFailure with _$AuthUserFailure {
  const factory AuthUserFailure.emailAlreadyInUse({String? message}) =
      EmailAlreadyInUse;
  const factory AuthUserFailure.invalidEmailAndPasswordCombination({
    String? message,
  }) = InvalidEmailAndPasswordCombination;
  const factory AuthUserFailure.serverError({String? message}) = ServerError;
  const factory AuthUserFailure.networkError({String? message}) = NetworkError;
  const factory AuthUserFailure.invalidOtp({String? message}) = InvalidOtp;
  const factory AuthUserFailure.oauthCallbackInvalid({String? message}) =
      OAuthCallbackInvalid;
  const factory AuthUserFailure.unsupportedOAuthProvider({String? message}) =
      UnsupportedOAuthProvider;
  const factory AuthUserFailure.oauthStateInvalidOrExpired({String? message}) =
      OAuthStateInvalidOrExpired;
  const factory AuthUserFailure.oauthProviderUnavailable({String? message}) =
      OAuthProviderUnavailable;
  const factory AuthUserFailure.oauthCancelled({String? message}) =
      OAuthCancelled;
  const factory AuthUserFailure.passwordChangeFailed({String? message}) =
      PasswordChangeFailed;
}
