// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'dart:convert';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/block_user_request.dart';
import '../models/block_user_response_body.dart';
import '../models/create_post_response_body.dart';
import '../models/create_thread_response_body.dart';
import '../models/delete_post_response_body.dart';
import '../models/follow_response_body.dart';
import '../models/get_category_response_body.dart';
import '../models/get_thread_response_body.dart';
import '../models/list_categories_response_body.dart';
import '../models/list_followed_categories_response_body.dart';
import '../models/list_followed_threads_response_body.dart';
import '../models/list_posts_response_body.dart';
import '../models/list_threads_response_body.dart';
import '../models/mark_solution_response_body.dart';
import '../models/report_post_request.dart';
import '../models/report_post_response_body.dart';
import '../models/report_thread_request.dart';
import '../models/report_thread_response_body.dart';
import '../models/report_user_request.dart';
import '../models/report_user_response_body.dart';
import '../models/update_post_response_body.dart';
import '../models/upload_attachments_response_body.dart';

part 'community_client.g.dart';

@RestApi()
abstract class CommunityClient {
  factory CommunityClient(Dio dio, {String? baseUrl}) = _CommunityClient;

  /// Upload attachments.
  ///
  /// Uploads one or more attachments for later use when creating/updating posts.
  ///
  /// [files] - Name not received - field will be skipped.
  @MultiPart()
  @POST('/api/v1/community/attachments')
  Future<HttpResponse<UploadAttachmentsResponseBody>> uploadAttachments({
    @Part(name: 'files') required List<MultipartFile> files,
  });

  /// Delete orphan attachment.
  ///
  /// Deletes a pending attachment that was uploaded but not yet linked to a post.
  ///
  /// [id] - Attachment ID.
  @DELETE('/api/v1/community/attachments/{id}')
  Future<HttpResponse<DeletePostResponseBody>> deleteOrphanAttachment({@Path('id') required String id});

  /// List community categories.
  ///
  /// Lists active community categories.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  ///
  /// [search] - Search term.
  @GET('/api/v1/community/categories')
  Future<HttpResponse<ListCategoriesResponseBody>> listCommunityCategories({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('search') String? search,
  });

  /// Get community category.
  ///
  /// Retrieves community category details.
  ///
  /// [id] - Category ID.
  @GET('/api/v1/community/categories/{id}')
  Future<HttpResponse<GetCategoryResponseBody>> getCommunityCategory({@Path('id') required String id});

  /// Unfollow category.
  ///
  /// Unfollows a community category.
  ///
  /// [id] - Category ID.
  @DELETE('/api/v1/community/categories/{id}/follow')
  Future<HttpResponse<FollowResponseBody>> unfollowCommunityCategory({@Path('id') required String id});

  /// Follow category.
  ///
  /// Follows a community category.
  ///
  /// [id] - Category ID.
  @POST('/api/v1/community/categories/{id}/follow')
  Future<HttpResponse<FollowResponseBody>> followCommunityCategory({@Path('id') required String id});

  /// List followed categories.
  ///
  /// Lists categories followed by the current user.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  ///
  /// [search] - Search term.
  @GET('/api/v1/community/follows/categories')
  Future<HttpResponse<ListFollowedCategoriesResponseBody>> listFollowedCategories({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('search') String? search,
  });

  /// List followed threads.
  ///
  /// Lists threads followed by the current user.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  ///
  /// [search] - Search term.
  @GET('/api/v1/community/follows/threads')
  Future<HttpResponse<ListFollowedThreadsResponseBody>> listFollowedThreads({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('search') String? search,
  });

  /// Delete post.
  ///
  /// Deletes a post.
  ///
  /// [id] - Post ID.
  @DELETE('/api/v1/community/posts/{id}')
  Future<HttpResponse<DeletePostResponseBody>> deleteCommunityPost({@Path('id') required String id});

  /// Update post.
  ///
  /// Updates a post.
  ///
  /// [id] - Post ID.
  ///
  /// [attachmentIds] - New attachment IDs to link (comma-separated).
  /// Name not received - field will be skipped.
  ///
  /// [content] - Post content.
  /// Name not received - field will be skipped.
  ///
  /// [removeAllAttachments] - Remove all attachments.
  /// Name not received - field will be skipped.
  ///
  /// [removeAttachmentIds] - Attachment IDs to unlink (comma-separated).
  /// Name not received - field will be skipped.
  @MultiPart()
  @PATCH('/api/v1/community/posts/{id}')
  Future<HttpResponse<UpdatePostResponseBody>> updateCommunityPost({
    @Path('id') required String id,
    @Part(name: 'content') required String content,
    @Part(name: 'removeAllAttachments') required bool removeAllAttachments,
    @Part(name: 'attachmentIds') String? attachmentIds,
    @Part(name: 'removeAttachmentIds') String? removeAttachmentIds,
  });

  /// List discussion threads.
  ///
  /// Lists discussion threads filtered by user's business profile taxonomy.
  ///
  /// [search] - Search term.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  @GET('/api/v1/community/threads')
  Future<HttpResponse<ListThreadsResponseBody>> listCommunityThreads({
    @Query('search') String? search,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Create discussion thread.
  ///
  /// Creates a thread with an initial post.
  ///
  /// [attachmentIds] - Pre-uploaded attachment IDs (comma-separated).
  /// Name not received - field will be skipped.
  ///
  /// [description] - Thread description.
  /// Name not received - field will be skipped.
  ///
  /// [initialPostContent] - Initial post content.
  /// Name not received - field will be skipped.
  ///
  /// [parentThreadId] - Parent thread ID for sub-threads.
  /// Name not received - field will be skipped.
  ///
  /// [sectorIds] - Sector IDs (comma-separated).
  /// Name not received - field will be skipped.
  ///
  /// [slug] - Thread slug.
  /// Name not received - field will be skipped.
  ///
  /// [tagIds] - Tag IDs (comma-separated).
  /// Name not received - field will be skipped.
  ///
  /// [title] - Thread title.
  /// Name not received - field will be skipped.
  @MultiPart()
  @POST('/api/v1/community/threads')
  Future<HttpResponse<CreateThreadResponseBody>> createCommunityThread({
    @Part(name: 'description') required String description,
    @Part(name: 'initialPostContent') required String initialPostContent,
    @Part(name: 'slug') required String slug,
    @Part(name: 'title') required String title,
    @Part(name: 'attachmentIds') String? attachmentIds,
    @Part(name: 'parentThreadId') String? parentThreadId,
    @Part(name: 'sectorIds') String? sectorIds,
    @Part(name: 'tagIds') String? tagIds,
  });

  /// Search discussion threads.
  ///
  /// Searches threads by keyword, filtered by user's business profile taxonomy.
  ///
  /// [keyword] - Search keyword.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  @GET('/api/v1/community/threads/search')
  Future<HttpResponse<ListThreadsResponseBody>> searchCommunityThreads({
    @Query('keyword') String? keyword,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Get discussion thread.
  ///
  /// Retrieves thread details.
  ///
  /// [id] - Thread ID.
  @GET('/api/v1/community/threads/{id}')
  Future<HttpResponse<GetThreadResponseBody>> getCommunityThread({@Path('id') required String id});

  /// Block user in thread.
  ///
  /// Blocks a user from a thread (thread author only).
  ///
  /// [id] - Thread ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/community/threads/{id}/blocks')
  Future<HttpResponse<BlockUserResponseBody>> blockCommunityUser({
    @Path('id') required String id,
    @Body() required BlockUserRequest body,
  });

  /// Unblock user in thread.
  ///
  /// Unblocks a user from a thread (thread author only).
  ///
  /// [id] - Thread ID.
  ///
  /// [accountId] - Blocked account ID.
  @DELETE('/api/v1/community/threads/{id}/blocks/{accountId}')
  Future<HttpResponse<BlockUserResponseBody>> unblockCommunityUser({
    @Path('id') required String id,
    @Path('accountId') required String accountId,
  });

  /// Unfollow thread.
  ///
  /// Unfollows a discussion thread.
  ///
  /// [id] - Thread ID.
  @DELETE('/api/v1/community/threads/{id}/follow')
  Future<HttpResponse<FollowResponseBody>> unfollowCommunityThread({@Path('id') required String id});

  /// Follow thread.
  ///
  /// Follows a discussion thread.
  ///
  /// [id] - Thread ID.
  @POST('/api/v1/community/threads/{id}/follow')
  Future<HttpResponse<FollowResponseBody>> followCommunityThread({@Path('id') required String id});

  /// List thread posts.
  ///
  /// Lists posts in a thread.
  ///
  /// [id] - Thread ID.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Page size.
  @GET('/api/v1/community/threads/{id}/posts')
  Future<HttpResponse<ListPostsResponseBody>> listCommunityPosts({
    @Path('id') required String id,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Create thread post.
  ///
  /// Creates a top-level post in a thread.
  ///
  /// [id] - Thread ID.
  ///
  /// [attachmentIds] - Pre-uploaded attachment IDs (comma-separated).
  /// Name not received - field will be skipped.
  ///
  /// [content] - Post content.
  /// Name not received - field will be skipped.
  @MultiPart()
  @POST('/api/v1/community/threads/{id}/posts')
  Future<HttpResponse<CreatePostResponseBody>> createCommunityPost({
    @Path('id') required String id,
    @Part(name: 'content') required String content,
    @Part(name: 'attachmentIds') String? attachmentIds,
  });

  /// Reply to post.
  ///
  /// Replies to a post in a thread.
  ///
  /// [id] - Thread ID.
  ///
  /// [postId] - Parent post ID.
  ///
  /// [attachmentIds] - Pre-uploaded attachment IDs (comma-separated).
  /// Name not received - field will be skipped.
  ///
  /// [content] - Post content.
  /// Name not received - field will be skipped.
  @MultiPart()
  @POST('/api/v1/community/threads/{id}/posts/{postId}/reply')
  Future<HttpResponse<CreatePostResponseBody>> replyCommunityPost({
    @Path('id') required String id,
    @Path('postId') required String postId,
    @Part(name: 'content') required String content,
    @Part(name: 'attachmentIds') String? attachmentIds,
  });

  /// Report post.
  ///
  /// Reports a discussion post.
  ///
  /// [id] - Thread ID.
  ///
  /// [postId] - Post ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/community/threads/{id}/posts/{postId}/reports')
  Future<HttpResponse<ReportPostResponseBody>> reportPost({
    @Path('id') required String id,
    @Path('postId') required String postId,
    @Body() required ReportPostRequest body,
  });

  /// Report thread.
  ///
  /// Reports a discussion thread.
  ///
  /// [id] - Thread ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/community/threads/{id}/reports')
  Future<HttpResponse<ReportThreadResponseBody>> reportThread({
    @Path('id') required String id,
    @Body() required ReportThreadRequest body,
  });

  /// Report user.
  ///
  /// Reports a user in a thread.
  ///
  /// [id] - Thread ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/community/threads/{id}/reports/user')
  Future<HttpResponse<ReportUserResponseBody>> reportUser({
    @Path('id') required String id,
    @Body() required ReportUserRequest body,
  });

  /// Mark accepted solution.
  ///
  /// Marks a post as the accepted solution.
  ///
  /// [id] - Thread ID.
  ///
  /// [postId] - Post ID.
  @POST('/api/v1/community/threads/{id}/solution/{postId}')
  Future<HttpResponse<MarkSolutionResponseBody>> markCommunitySolution({
    @Path('id') required String id,
    @Path('postId') required String postId,
  });
}
