// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/login_request.dart';
import '../models/login_response_body.dart';
import '../models/refresh_response_body.dart';
import '../models/register_request.dart';
import '../models/register_response_body.dart';

part 'authentication_client.g.dart';

@RestApi()
abstract class AuthenticationClient {
  factory AuthenticationClient(Dio dio, {String? baseUrl}) =
      _AuthenticationClient;

  /// Log in a user.
  ///
  /// Authenticates a user with email and password, returns authentication tokens.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/auth/login')
  Future<LoginResponseBody> login({
    @Body() required LoginRequest body,
  });

  /// Log out current session.
  ///
  /// Revokes the current session and clears the refresh token cookie.
  @POST('/api/v1/auth/logout')
  Future<void> logout();

  /// Log out all sessions.
  ///
  /// Revokes all sessions for the current user's account and clears the refresh token cookie.
  @POST('/api/v1/auth/logout/all')
  Future<void> logoutAll();

  /// Refresh access token.
  ///
  /// Uses the refresh token cookie to issue new access and refresh tokens. Implements token rotation for security.
  @POST('/api/v1/auth/refresh')
  Future<RefreshResponseBody> refresh();

  /// Register a new user.
  ///
  /// Creates a new user account and returns authentication tokens. The user is automatically logged in after registration.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/auth/register')
  Future<RegisterResponseBody> register({
    @Body() required RegisterRequest body,
  });
}
