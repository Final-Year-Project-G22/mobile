// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/admin_list_response_body.dart';
import '../models/reset_admin_password_output_body.dart';
import '../models/update_admin_status_output_body.dart';
import '../models/update_admin_status_request.dart';

part 'admin_management_client.g.dart';

@RestApi()
abstract class AdminManagementClient {
  factory AdminManagementClient(Dio dio, {String? baseUrl}) = _AdminManagementClient;

  /// List admin accounts.
  ///
  /// Returns a paginated list of admin accounts filtered by search, status, and role.
  ///
  /// [search] - Search by email, username, or name.
  ///
  /// [status] - Filter by account status.
  ///
  /// [roleId] - Filter by role ID.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/admin/accounts')
  Future<HttpResponse<AdminListResponseBody>> listAdmins({
    @Query('page') int? page = 1,
    @Query('pageSize') int? pageSize = 20,
    @Query('search') String? search,
    @Query('status') String? status,
    @Query('roleId') String? roleId,
  });

  /// Trigger admin password reset.
  ///
  /// Triggers a password reset for an admin account by sending an OTP to their email.
  ///
  /// [accountId] - Account identifier.
  @POST('/api/v1/admin/accounts/{accountId}/reset-password')
  Future<HttpResponse<ResetAdminPasswordOutputBody>> resetAdminPassword({@Path('accountId') required String accountId});

  /// Update admin account status.
  ///
  /// Updates the status of an admin account (active, locked, suspended).
  ///
  /// [accountId] - Account identifier.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/accounts/{accountId}/status')
  Future<HttpResponse<UpdateAdminStatusOutputBody>> updateAdminStatus({
    @Path('accountId') required String accountId,
    @Body() required UpdateAdminStatusRequest body,
  });
}
