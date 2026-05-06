// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/add_bookmark_response_body.dart';
import '../models/complete_step_request.dart';
import '../models/complete_step_response_body.dart';
import '../models/get_category_tree_response_body.dart';
import '../models/get_current_step_response_body.dart';
import '../models/get_personalized_guide_response_body.dart';
import '../models/get_recently_viewed_response_body.dart';
import '../models/list_bookmarks_response_body.dart';
import '../models/mark_step_incomplete_response_body.dart';
import '../models/remove_bookmark_response_body.dart';
import '../models/search_guides_response_body.dart';
import '../models/skip_optional_step_response_body.dart';
import '../models/start_step_response_body.dart';
import '../models/update_bookmark_note_request.dart';
import '../models/update_bookmark_note_response_body.dart';
import '../models/update_progress_request.dart';
import '../models/update_progress_response_body.dart';

part 'guides_client.g.dart';

@RestApi()
abstract class GuidesClient {
  factory GuidesClient(Dio dio, {String? baseUrl}) = _GuidesClient;

  /// List bookmarks.
  ///
  /// Lists all bookmarks for the user.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/guides/bookmarks')
  Future<HttpResponse<ListBookmarksResponseBody>> listBookmarks({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Get guide category tree.
  ///
  /// Retrieves the hierarchical category tree for guides with localized names.
  ///
  /// [locale] - Language locale (en, am).
  @GET('/api/v1/guides/categories/tree')
  Future<HttpResponse<GetCategoryTreeResponseBody>> getCategoryTree({@Query('locale') String? locale});

  /// Get recently viewed guides.
  ///
  /// Retrieves the user's recently viewed guides with localized names.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  ///
  /// [locale] - Language locale (en, am).
  @GET('/api/v1/guides/recent')
  Future<HttpResponse<GetRecentlyViewedResponseBody>> getRecentlyViewed({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('locale') String? locale,
  });

  /// Search guides.
  ///
  /// Searches guides by keyword with localized results.
  ///
  /// [q] - Search keyword.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  ///
  /// [locale] - Language locale (en, am).
  @GET('/api/v1/guides/search')
  Future<HttpResponse<SearchGuidesResponseBody>> searchGuides({
    @Query('q') String? q,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('locale') String? locale,
  });

  /// Remove bookmark.
  ///
  /// Removes a bookmark from a step.
  ///
  /// [stepId] - Step ID.
  @DELETE('/api/v1/guides/steps/{stepId}/bookmark')
  Future<HttpResponse<RemoveBookmarkResponseBody>> removeBookmark({@Path('stepId') required String stepId});

  /// Update bookmark note.
  ///
  /// Updates the note on an existing bookmark.
  ///
  /// [stepId] - Step ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/guides/steps/{stepId}/bookmark')
  Future<HttpResponse<UpdateBookmarkNoteResponseBody>> updateBookmarkNote({
    @Path('stepId') required String stepId,
    @Body() required UpdateBookmarkNoteRequest body,
  });

  /// Add bookmark.
  ///
  /// Bookmarks a step with an optional note.
  ///
  /// [stepId] - Step ID.
  @POST('/api/v1/guides/steps/{stepId}/bookmark')
  Future<HttpResponse<AddBookmarkResponseBody>> addBookmark({@Path('stepId') required String stepId});

  /// Complete a step.
  ///
  /// Marks a step as completed with optional documents and notes.
  ///
  /// [stepId] - Step ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/guides/steps/{stepId}/complete')
  Future<HttpResponse<CompleteStepResponseBody>> completeStep({
    @Path('stepId') required String stepId,
    @Body() required CompleteStepRequest body,
  });

  /// Mark step as incomplete.
  ///
  /// Resets a step's status to in-progress.
  ///
  /// [stepId] - Step ID.
  @POST('/api/v1/guides/steps/{stepId}/mark-incomplete')
  Future<HttpResponse<MarkStepIncompleteResponseBody>> markStepIncomplete({@Path('stepId') required String stepId});

  /// Update step progress.
  ///
  /// Updates progress details for a step including documents and notes.
  ///
  /// [stepId] - Step ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/guides/steps/{stepId}/progress')
  Future<HttpResponse<UpdateProgressResponseBody>> updateProgress({
    @Path('stepId') required String stepId,
    @Body() required UpdateProgressRequest body,
  });

  /// Skip an optional step.
  ///
  /// Skips an optional step with an optional reason.
  ///
  /// [stepId] - Step ID.
  @POST('/api/v1/guides/steps/{stepId}/skip')
  Future<HttpResponse<SkipOptionalStepResponseBody>> skipOptionalStep({@Path('stepId') required String stepId});

  /// Start a step.
  ///
  /// Marks a step as in-progress for the user.
  ///
  /// [stepId] - Step ID.
  @POST('/api/v1/guides/steps/{stepId}/start')
  Future<HttpResponse<StartStepResponseBody>> startStep({@Path('stepId') required String stepId});

  /// Get personalized guide.
  ///
  /// Retrieves a guide with personalized step statuses based on user progress.
  ///
  /// [guideSlug] - Guide slug.
  ///
  /// [locale] - Language locale (en, am).
  @GET('/api/v1/guides/{guideSlug}')
  Future<HttpResponse<GetPersonalizedGuideResponseBody>> getPersonalizedGuide({
    @Path('guideSlug') required String guideSlug,
    @Query('locale') String? locale,
  });

  /// Get current step.
  ///
  /// Returns the next incomplete step in a guide for the user.
  ///
  /// [guideSlug] - Guide slug.
  ///
  /// [locale] - Language locale (en, am).
  @GET('/api/v1/guides/{guideSlug}/current-step')
  Future<HttpResponse<GetCurrentStepResponseBody>> getCurrentStep({
    @Path('guideSlug') required String guideSlug,
    @Query('locale') String? locale,
  });
}
