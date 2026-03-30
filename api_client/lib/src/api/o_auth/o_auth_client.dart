// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/get_o_auth_providers_response.dart';
import '../models/o_auth_callback_response.dart';
import '../models/o_auth_complete_email_request.dart';
import '../models/o_auth_identities_response.dart';
import '../models/o_auth_link_callback_output_body.dart';
import '../models/o_auth_unlink_output_body.dart';

part 'o_auth_client.g.dart';

@RestApi()
abstract class OAuthClient {
  factory OAuthClient(Dio dio, {String? baseUrl}) = _OAuthClient;

  /// OAuth callback.
  ///
  /// Handles the OAuth callback from the provider.
  @GET('/api/v1/auth/oauth/callback/{provider}')
  Future<HttpResponse<OAuthCallbackResponse>> oauthCallback({
    @Path('provider') required String provider,
    @Query('code') String? code,
    @Query('state') String? state,
  });

  /// Complete OAuth with email.
  ///
  /// Completes OAuth flow when email is required.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/auth/oauth/complete')
  Future<HttpResponse<OAuthCallbackResponse>> oauthCompleteWithEmail({@Body() required OAuthCompleteEmailRequest body});

  /// List linked OAuth identities.
  ///
  /// Returns all OAuth providers linked to the authenticated account.
  @GET('/api/v1/auth/oauth/identities')
  Future<HttpResponse<OAuthIdentitiesResponse>> getOAuthIdentities();

  /// Unlink OAuth provider.
  ///
  /// Unlinks an OAuth provider from the authenticated account.
  @DELETE('/api/v1/auth/oauth/identities/{provider}')
  Future<HttpResponse<OAuthUnlinkOutputBody>> unlinkOAuthProvider({@Path('provider') required String provider});

  /// OAuth link callback.
  ///
  /// Handles the OAuth callback when linking a provider.
  @GET('/api/v1/auth/oauth/link/callback/{provider}')
  Future<HttpResponse<OAuthLinkCallbackOutputBody>> oauthLinkCallback({
    @Path('provider') required String provider,
    @Query('code') String? code,
    @Query('state') String? state,
  });

  /// Initiate OAuth link.
  ///
  /// Initiates linking an OAuth provider to the authenticated account.
  @GET('/api/v1/auth/oauth/link/{provider}')
  Future<HttpResponse<void>> initiateOAuthLink({@Path('provider') required String provider});

  /// Initiate OAuth login.
  ///
  /// Redirects to the OAuth provider for authentication.
  @GET('/api/v1/auth/oauth/login/{provider}')
  Future<HttpResponse<void>> initiateOAuthLogin({@Path('provider') required String provider});

  /// List OAuth providers.
  ///
  /// Returns a list of available OAuth providers for authentication.
  @GET('/api/v1/auth/oauth/providers')
  Future<HttpResponse<GetOAuthProvidersResponse>> getOAuthProviders();
}
