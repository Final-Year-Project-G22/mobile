// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;

import 'authentication/authentication_client.dart';

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

  AuthenticationClient? _authentication;

  AuthenticationClient get authentication =>
      _authentication ??= AuthenticationClient(_dio, baseUrl: _baseUrl);
}
