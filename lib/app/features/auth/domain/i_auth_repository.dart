import 'package:dartz/dartz.dart';

import 'entities/auth_response.dart';
import 'entities/oauth_callback_result.dart';
import 'entities/oauth_provider.dart';
import 'failures/auth_user_failure.dart';

abstract class IAuthRepository {
  Future<Either<AuthUserFailure, AuthResponse>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? username,
  });

  Future<Either<AuthUserFailure, AuthResponse>> login({
    required String identifier,
    required String password,
  });

  Future<Either<AuthUserFailure, List<OAuthProvider>>> getOAuthProviders();

  Future<Either<AuthUserFailure, OAuthCallbackResult>> handleOAuthCallback({
    required String provider,
    String? code,
    String? state,
  });

  Future<Either<AuthUserFailure, OAuthCallbackResult>> completeOAuthWithEmail({
    required String email,
    required String state,
  });
  Future<Either<AuthUserFailure, AuthResponse>> getCurrentUser();
  Future<Either<AuthUserFailure, Unit>> logout();

  Future<Either<AuthUserFailure, Unit>> logoutAll();

  Future<Either<AuthUserFailure, String>> verifyOtp({required String otp});

  Future<Either<AuthUserFailure, String>> resendOtp();

  Future<Either<AuthUserFailure, String>> changePassword({
    required String existingPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
