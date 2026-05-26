// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/account_preference_response.dart';
import '../models/admin_register_request.dart';
import '../models/admin_register_response_body.dart';
import '../models/admin_update_roles_output_body.dart';
import '../models/admin_update_roles_request.dart';
import '../models/complete_admin_password_reset_output_body.dart';
import '../models/complete_admin_password_reset_request.dart';
import '../models/get_current_user_response_body.dart';
import '../models/login_request.dart';
import '../models/login_response_body.dart';
import '../models/refresh_response_body.dart';
import '../models/register_request.dart';
import '../models/register_response_body.dart';
import '../models/resend_email_otp_response_body.dart';
import '../models/update_account_password_request.dart';
import '../models/update_account_password_response_body.dart';
import '../models/update_account_preference_request.dart';
import '../models/verify_email_otp_request.dart';
import '../models/verify_email_otp_response_body.dart';

part 'authentication_client.g.dart';

@RestApi()
abstract class AuthenticationClient {
  factory AuthenticationClient(Dio dio, {String? baseUrl}) =
      _AuthenticationClient;

  /// Register a new admin.
  ///
  /// Creates an admin account and emails the generated password.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/auth/admin/register')
  Future<HttpResponse<AdminRegisterResponseBody>> registerAdmin({
    @Body() required AdminRegisterRequest body,
  });

  /// Complete admin password reset.
  ///
  /// Validates the reset token and sets a new password for the admin account.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/auth/admin/reset-password')
  Future<HttpResponse<CompleteAdminPasswordResetOutputBody>>
  completeAdminPasswordReset({
    @Body() required CompleteAdminPasswordResetRequest body,
  });

  /// Update admin roles.
  ///
  /// Replaces roles assigned to an admin account.
  ///
  /// [accountId] - Admin account ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/auth/admin/{accountId}/roles')
  Future<HttpResponse<AdminUpdateRolesOutputBody>> updateAdminRoles({
    @Path('accountId') required String accountId,
    @Body() required AdminUpdateRolesRequest body,
  });

  /// Log in a user.
  ///
  /// Authenticates a user with email or username and password, returns authentication tokens.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/auth/login')
  Future<HttpResponse<LoginResponseBody>> login({
    @Body() required LoginRequest body,
  });

  /// Log out current session.
  ///
  /// Revokes the current session and clears the refresh token cookie.
  @POST('/api/v1/auth/logout')
  Future<HttpResponse<void>> logout();

  /// Log out all sessions.
  ///
  /// Revokes all sessions for the current user's account and clears the refresh token cookie.
  @POST('/api/v1/auth/logout/all')
  Future<HttpResponse<void>> logoutAll();

  /// Get current user.
  ///
  /// Returns the current authenticated user's profile and account information.
  @GET('/api/v1/auth/me')
  Future<HttpResponse<GetCurrentUserResponseBody>> getCurrentUser();

  /// Get account preferences.
  ///
  /// Returns the language and timezone preferences for the authenticated user.
  @GET('/api/v1/auth/preferences')
  Future<HttpResponse<AccountPreferenceResponse>> getAccountPreferences();

  /// Update account preferences.
  ///
  /// Updates the language and timezone preferences for the authenticated user.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/auth/preferences')
  Future<HttpResponse<AccountPreferenceResponse>> updateAccountPreferences({
    @Body() required UpdateAccountPreferenceRequest body,
  });

  /// Refresh access token.
  ///
  /// Uses the refresh token cookie to issue new access and refresh tokens. Implements token rotation for security.
  @POST('/api/v1/auth/refresh')
  Future<HttpResponse<RefreshResponseBody>> refresh();

  /// Register a new user.
  ///
  /// Creates a new user account and returns authentication tokens. The user is automatically logged in after registration.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/auth/register')
  Future<HttpResponse<RegisterResponseBody>> register({
    @Body() required RegisterRequest body,
  });

  /// Resend account email OTP.
  ///
  /// Resends a new one-time password for email verification with cooldown and resend limits.
  @POST('/api/v1/auth/resend-email-otp')
  Future<HttpResponse<ResendEmailOtpResponseBody>> resendEmailOtp();

  /// Update account password.
  ///
  /// Updates account password.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/auth/user/updatePassword')
  Future<HttpResponse<UpdateAccountPasswordResponseBody>> accountPassword({
    @Body() required UpdateAccountPasswordRequest body,
  });

  /// Verify account email with OTP.
  ///
  /// Verifies pending account email using a one-time password and activates the account.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/auth/verify-email-otp')
  Future<HttpResponse<VerifyEmailOtpResponseBody>> verifyEmailOtp({
    @Body() required VerifyEmailOtpRequest body,
  });
}
