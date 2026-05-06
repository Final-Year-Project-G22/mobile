// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/list_permissions_response_body.dart';

part 'permissions_client.g.dart';

@RestApi()
abstract class PermissionsClient {
  factory PermissionsClient(Dio dio, {String? baseUrl}) = _PermissionsClient;

  /// List permissions.
  ///
  /// Returns permissions with optional filtering by module and code.
  ///
  /// [module] - Filter by module.
  ///
  /// [code] - Filter by permission code.
  @GET('/api/v1/permissions')
  Future<HttpResponse<ListPermissionsResponseBody>> listPermissions({
    @Query('module') String? module,
    @Query('code') List<dynamic>? code,
  });
}
