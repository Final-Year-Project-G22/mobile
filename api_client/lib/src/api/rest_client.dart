// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;

import 'admin_community/admin_community_client.dart';
import 'authentication/authentication_client.dart';
import 'o_auth/o_auth_client.dart';
import 'community/community_client.dart';
import 'permissions/permissions_client.dart';
import 'roles/roles_client.dart';
import 'users/users_client.dart';

/// Adisu Backend API `v1.0.0`.
///
/// Backend API for the Adisu platform.
class RestClient {
  RestClient(
    Dio dio, {
    String? baseUrl,
  }) : _dio = dio,
       _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '1.0.0';

  AdminCommunityClient? _adminCommunity;
  AuthenticationClient? _authentication;
  OAuthClient? _oAuth;
  CommunityClient? _community;
  PermissionsClient? _permissions;
  RolesClient? _roles;
  UsersClient? _users;

  AdminCommunityClient get adminCommunity =>
      _adminCommunity ??= AdminCommunityClient(_dio, baseUrl: _baseUrl);

  AuthenticationClient get authentication =>
      _authentication ??= AuthenticationClient(_dio, baseUrl: _baseUrl);

  OAuthClient get oAuth => _oAuth ??= OAuthClient(_dio, baseUrl: _baseUrl);

  CommunityClient get community =>
      _community ??= CommunityClient(_dio, baseUrl: _baseUrl);

  PermissionsClient get permissions =>
      _permissions ??= PermissionsClient(_dio, baseUrl: _baseUrl);

  RolesClient get roles => _roles ??= RolesClient(_dio, baseUrl: _baseUrl);

  UsersClient get users => _users ??= UsersClient(_dio, baseUrl: _baseUrl);
}
