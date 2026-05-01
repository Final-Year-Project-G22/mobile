// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/create_role_request.dart';
import '../models/create_role_response_body.dart';
import '../models/delete_role_output_body.dart';
import '../models/get_role_response_body.dart';
import '../models/list_roles_response_body.dart';
import '../models/update_role_request.dart';
import '../models/update_role_response_body.dart';

part 'roles_client.g.dart';

@RestApi()
abstract class RolesClient {
  factory RolesClient(Dio dio, {String? baseUrl}) = _RolesClient;

  /// List roles.
  ///
  /// Returns all roles.
  @GET('/api/v1/roles')
  Future<HttpResponse<ListRolesResponseBody>> listRoles();

  /// Create role.
  ///
  /// Creates a custom role and assigns permissions.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/roles')
  Future<HttpResponse<CreateRoleResponseBody>> createRole({
    @Body() required CreateRoleRequest body,
  });

  /// Delete role.
  ///
  /// Permanently deletes a role if it is mutable.
  ///
  /// [roleId] - Role identifier.
  @DELETE('/api/v1/roles/{roleId}')
  Future<HttpResponse<DeleteRoleOutputBody>> deleteRole({
    @Path('roleId') required String roleId,
  });

  /// Get role.
  ///
  /// Returns role details and its permissions.
  ///
  /// [roleId] - Role identifier.
  @GET('/api/v1/roles/{roleId}')
  Future<HttpResponse<GetRoleResponseBody>> getRole({
    @Path('roleId') required String roleId,
  });

  /// Update role.
  ///
  /// Updates role details and replaces permissions.
  ///
  /// [roleId] - Role identifier.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/roles/{roleId}')
  Future<HttpResponse<UpdateRoleResponseBody>> updateRole({
    @Path('roleId') required String roleId,
    @Body() required UpdateRoleRequest body,
  });
}
