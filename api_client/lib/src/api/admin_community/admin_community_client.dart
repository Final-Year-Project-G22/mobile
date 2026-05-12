// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/block_reported_user_request.dart';
import '../models/block_reported_user_response_body.dart';
import '../models/block_user_request.dart';
import '../models/block_user_response_body.dart';
import '../models/create_community_category_request.dart';
import '../models/create_community_category_response_body.dart';
import '../models/delete_community_category_response_body.dart';
import '../models/delete_reported_content_response_body.dart';
import '../models/get_post_report_response_body.dart';
import '../models/get_thread_report_response_body.dart';
import '../models/get_user_report_response_body.dart';
import '../models/list_all_blocked_users_response_body.dart';
import '../models/list_blocked_users_response_body.dart';
import '../models/list_categories_response_body.dart';
import '../models/list_post_reports_response_body.dart';
import '../models/list_thread_reports_response_body.dart';
import '../models/list_user_reports_response_body.dart';
import '../models/update_community_category_request.dart';
import '../models/update_community_category_response_body.dart';
import '../models/update_post_report_status_request.dart';
import '../models/update_post_report_status_response_body.dart';
import '../models/update_thread_report_status_request.dart';
import '../models/update_thread_report_status_response_body.dart';
import '../models/update_user_report_status_request.dart';
import '../models/update_user_report_status_response_body.dart';

part 'admin_community_client.g.dart';

@RestApi()
abstract class AdminCommunityClient {
  factory AdminCommunityClient(Dio dio, {String? baseUrl}) =
      _AdminCommunityClient;

  /// List all blocked users (admin).
  ///
  /// Lists all blocked users across all threads.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  @GET('/api/v1/admin/community/blocks')
  Future<HttpResponse<ListAllBlockedUsersResponseBody>>
  adminListAllBlockedUsers({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// List community categories (admin).
  ///
  /// Lists community categories including inactive ones.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  ///
  /// [includeInactive] - Include inactive categories.
  @GET('/api/v1/admin/community/categories')
  Future<HttpResponse<ListCategoriesResponseBody>>
  adminListCommunityCategories({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('includeInactive') bool? includeInactive,
  });

  /// Create community category.
  ///
  /// Creates a community category.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/community/categories')
  Future<HttpResponse<CreateCommunityCategoryResponseBody>>
  adminCreateCommunityCategory({
    @Body() required CreateCommunityCategoryRequest body,
  });

  /// Delete community category.
  ///
  /// Deletes a community category.
  ///
  /// [id] - Category ID.
  @DELETE('/api/v1/admin/community/categories/{id}')
  Future<HttpResponse<DeleteCommunityCategoryResponseBody>>
  adminDeleteCommunityCategory({
    @Path('id') required String id,
  });

  /// Update community category.
  ///
  /// Updates a community category.
  ///
  /// [id] - Category ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/admin/community/categories/{id}')
  Future<HttpResponse<UpdateCommunityCategoryResponseBody>>
  adminUpdateCommunityCategory({
    @Path('id') required String id,
    @Body() required UpdateCommunityCategoryRequest body,
  });

  /// List post reports (admin).
  ///
  /// Lists post reports with optional status filter.
  ///
  /// [status] - Filter by status: pending, under_review, resolved, dismissed.
  ///
  /// [search] - Search in post content.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  @GET('/api/v1/admin/community/reports/posts')
  Future<HttpResponse<ListPostReportsResponseBody>> adminListPostReports({
    @Query('status') String? status,
    @Query('search') String? search,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Delete reported post (admin).
  ///
  /// Deletes a reported post and resolves the report.
  ///
  /// [id] - Report ID.
  @DELETE('/api/v1/admin/community/reports/posts/{id}')
  Future<HttpResponse<DeleteReportedContentResponseBody>>
  adminDeleteReportedPost({
    @Path('id') required String id,
  });

  /// Get post report (admin).
  ///
  /// Gets a post report with reported content details.
  ///
  /// [id] - Report ID.
  @GET('/api/v1/admin/community/reports/posts/{id}')
  Future<HttpResponse<GetPostReportResponseBody>> adminGetPostReport({
    @Path('id') required String id,
  });

  /// Update post report status (admin).
  ///
  /// Updates a post report status.
  ///
  /// [id] - Report ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/community/reports/posts/{id}/status')
  Future<HttpResponse<UpdatePostReportStatusResponseBody>>
  adminUpdatePostReportStatus({
    @Path('id') required String id,
    @Body() required UpdatePostReportStatusRequest body,
  });

  /// List thread reports (admin).
  ///
  /// Lists thread reports with optional status filter.
  ///
  /// [status] - Filter by status: pending, under_review, resolved, dismissed.
  ///
  /// [search] - Search in thread title, slug, description.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  @GET('/api/v1/admin/community/reports/threads')
  Future<HttpResponse<ListThreadReportsResponseBody>> adminListThreadReports({
    @Query('status') String? status,
    @Query('search') String? search,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Delete reported thread (admin).
  ///
  /// Deletes a reported thread and resolves the report.
  ///
  /// [id] - Report ID.
  @DELETE('/api/v1/admin/community/reports/threads/{id}')
  Future<HttpResponse<DeleteReportedContentResponseBody>>
  adminDeleteReportedThread({
    @Path('id') required String id,
  });

  /// Get thread report (admin).
  ///
  /// Gets a thread report with reported content details.
  ///
  /// [id] - Report ID.
  @GET('/api/v1/admin/community/reports/threads/{id}')
  Future<HttpResponse<GetThreadReportResponseBody>> adminGetThreadReport({
    @Path('id') required String id,
  });

  /// Update thread report status (admin).
  ///
  /// Updates a thread report status.
  ///
  /// [id] - Report ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/community/reports/threads/{id}/status')
  Future<HttpResponse<UpdateThreadReportStatusResponseBody>>
  adminUpdateThreadReportStatus({
    @Path('id') required String id,
    @Body() required UpdateThreadReportStatusRequest body,
  });

  /// List user reports (admin).
  ///
  /// Lists user reports with optional status filter.
  ///
  /// [status] - Filter by status: pending, under_review, resolved, dismissed.
  ///
  /// [search] - Search in reporter first name, last name, email.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  @GET('/api/v1/admin/community/reports/users')
  Future<HttpResponse<ListUserReportsResponseBody>> adminListUserReports({
    @Query('status') String? status,
    @Query('search') String? search,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Get user report (admin).
  ///
  /// Gets a user report with reported user details.
  ///
  /// [id] - Report ID.
  @GET('/api/v1/admin/community/reports/users/{id}')
  Future<HttpResponse<GetUserReportResponseBody>> adminGetUserReport({
    @Path('id') required String id,
  });

  /// Block reported user (admin).
  ///
  /// Blocks the reported user from the thread and resolves the report.
  ///
  /// [id] - Report ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/community/reports/users/{id}/block')
  Future<HttpResponse<BlockReportedUserResponseBody>> adminBlockReportedUser({
    @Path('id') required String id,
    @Body() required BlockReportedUserRequest body,
  });

  /// Update user report status (admin).
  ///
  /// Updates a user report status.
  ///
  /// [id] - Report ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/community/reports/users/{id}/status')
  Future<HttpResponse<UpdateUserReportStatusResponseBody>>
  adminUpdateUserReportStatus({
    @Path('id') required String id,
    @Body() required UpdateUserReportStatusRequest body,
  });

  /// List blocked users in thread (admin).
  ///
  /// Lists blocked users for a specific thread.
  ///
  /// [id] - Thread ID.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  @GET('/api/v1/admin/community/threads/{id}/blocks')
  Future<HttpResponse<ListBlockedUsersResponseBody>>
  adminListThreadBlockedUsers({
    @Path('id') required String id,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Block user in thread (admin).
  ///
  /// Blocks a user from a thread as admin.
  ///
  /// [id] - Thread ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/community/threads/{id}/blocks')
  Future<HttpResponse<BlockUserResponseBody>> adminBlockCommunityUser({
    @Path('id') required String id,
    @Body() required BlockUserRequest body,
  });

  /// Unblock user in thread (admin).
  ///
  /// Unblocks a user from a thread as admin.
  ///
  /// [id] - Thread ID.
  ///
  /// [accountId] - Blocked account ID.
  @DELETE('/api/v1/admin/community/threads/{id}/blocks/{accountId}')
  Future<HttpResponse<BlockUserResponseBody>> adminUnblockCommunityUser({
    @Path('id') required String id,
    @Path('accountId') required String accountId,
  });
}
