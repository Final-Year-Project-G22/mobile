import 'package:api_client/api_client.dart';
import 'package:cross_file/cross_file.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../domain/entities/attachment.dart';
import '../domain/entities/discussion_post.dart';
import '../domain/entities/discussion_thread.dart';
import '../domain/failures/community_failure.dart';
import '../domain/i_community_repository.dart';

class CommunityRepositoryImpl implements ICommunityRepository {
  const CommunityRepositoryImpl(this._client);

  final CommunityClient _client;

  @override
  Future<Either<CommunityFailure, List<DiscussionThread>>> listThreads({
    String? search,
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await _client.listCommunityThreads(
        search: search,
        page: page,
        pageSize: pageSize,
      );

      final threads = (response.data.threads ?? [])
          .cast<Map<String, dynamic>>()
          .map(
            (json) =>
                _mapThreadDtoToDomain(ThreadDto.fromJson(json), json: json),
          )
          .toList();

      return Right(threads);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, List<DiscussionThread>>> listAllThreads({
    String? search,
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await _client.listAllCommunityThreads(
        search: search,
        page: page,
        pageSize: pageSize,
      );

      final threads = (response.data.threads ?? [])
          .cast<Map<String, dynamic>>()
          .map(
            (json) => _mapThreadDtoToDomain(ThreadDto.fromJson(json), json: json),
          )
          .toList();

      return Right(threads);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, DiscussionThread>> getThread(
    String threadId,
  ) async {
    try {
      final response = await _client.getCommunityThread(id: threadId);
      final threadDto = response.data.thread;
      final responseMap = response.response.data;
      final threadMap = responseMap is Map<String, dynamic>
          ? responseMap['thread'] as Map<String, dynamic>?
          : null;
      return Right(_mapThreadDtoToDomain(threadDto, json: threadMap));
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, List<DiscussionPost>>> getPosts(
    String threadId, {
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await _client.listCommunityPosts(
        id: threadId,
        page: page,
        pageSize: pageSize,
      );

      final posts = (response.data.posts ?? []).map((e) {
        final json = e as Map<String, dynamic>;
        final dto = PostDto.fromJson(json);
        return _mapPostDtoToDomain(dto, json: json);
      }).toList();

      return Right(posts);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, List<DiscussionThread>>> searchThreads({
    String? keyword,
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await _client.searchCommunityThreads(
        keyword: keyword,
        page: page,
        pageSize: pageSize,
      );

      final threads = (response.data.threads ?? [])
          .cast<Map<String, dynamic>>()
          .map(
            (json) =>
                _mapThreadDtoToDomain(ThreadDto.fromJson(json), json: json),
          )
          .toList();

      return Right(threads);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, List<Attachment>>> uploadAttachments(
    List<XFile> files,
  ) async {
    try {
      debugPrint('Repository: uploadAttachments - ${files.length} files');

      // Upload files one by one to avoid "message too large" error
      final allAttachments = <Attachment>[];

      for (final file in files) {
        final bytes = await file.readAsBytes();
        debugPrint(
          'Repository: Uploading file ${file.name} (${bytes.length} bytes)',
        );

        // Skip empty files
        if (bytes.isEmpty) {
          debugPrint('Repository: Skipping empty file: ${file.name}');
          continue;
        }

        final response = await _client.uploadAttachments(
          files: [
            MultipartFile.fromBytes(
              bytes,
              filename: file.name,
            ),
          ],
        );

        debugPrint(
          'Repository: API response for ${file.name}: ${response.data.attachments?.length} attachments',
        );

        final attachments = (response.data.attachments ?? [])
            .map((e) => Attachment.fromJson(e as Map<String, dynamic>))
            .toList();

        allAttachments.addAll(attachments);
        debugPrint(
          'Repository: Uploaded ${allAttachments.length}/${files.length} files',
        );
      }

      debugPrint(
        'Repository: Total uploaded: ${allAttachments.length} attachments',
      );
      return Right(allAttachments);
    } on DioException catch (e) {
      debugPrint('Repository: DioException: ${e.message}');
      debugPrint('Repository: Error response: ${e.response?.data}');
      return Left(_handleDioError(e));
    } on Exception catch (e) {
      debugPrint('Repository: Exception: $e');
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> deleteOrphanAttachment(
    String id,
  ) async {
    try {
      await _client.deleteOrphanAttachment(id: id);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, String>> createThread({
    required String title,
    required String slug,
    required String description,
    required String initialPostContent,
    List<String>? sectorIds,
    List<String>? tagIds,
    String? parentThreadId,
    String? attachmentIds,
  }) async {
    try {
      final response = await _client.createCommunityThread(
        title: title,
        slug: slug,
        description: description,
        initialPostContent: initialPostContent,
        sectorIds: sectorIds?.join(','),
        tagIds: tagIds?.join(','),
        parentThreadId: parentThreadId,
        attachmentIds: attachmentIds,
      );

      return Right(response.data.threadId);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> updateThread(
    String threadId, {
    String? title,
    String? description,
    List<String>? sectorIds,
    List<String>? tagIds,
  }) async {
    try {
      await _client.updateCommunityThread(
        id: threadId,
        title: title,
        description: description,
        sectorIds: sectorIds?.join(','),
        tagIds: tagIds?.join(','),
      );

      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> deleteThread(String threadId) async {
    try {
      await _client.deleteCommunityThread(id: threadId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, String>> createPost({
    required String threadId,
    required String content,
    String? attachmentIds,
  }) async {
    try {
      final response = await _client.createCommunityPost(
        id: threadId,
        content: content,
        attachmentIds: attachmentIds,
      );

      return Right(response.data.postId);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, String>> replyToPost({
    required String threadId,
    required String postId,
    required String content,
    String? attachmentIds,
  }) async {
    try {
      final response = await _client.replyCommunityPost(
        id: threadId,
        postId: postId,
        content: content,
        attachmentIds: attachmentIds,
      );

      return Right(response.data.postId);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> updatePost(
    String postId, {
    required String content,
    String? attachmentIds,
    bool removeAllAttachments = false,
    String? removeAttachmentIds,
  }) async {
    try {
      await _client.updateCommunityPost(
        id: postId,
        content: content,
        attachmentIds: attachmentIds,
        removeAllAttachments: removeAllAttachments,
        removeAttachmentIds: removeAttachmentIds,
      );

      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> deletePost(String postId) async {
    try {
      await _client.deleteCommunityPost(id: postId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> followThread(String threadId) async {
    try {
      await _client.followCommunityThread(id: threadId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> unfollowThread(String threadId) async {
    try {
      await _client.unfollowCommunityThread(id: threadId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> markThreadRead(String threadId) async {
    try {
      await _client.markThreadRead(id: threadId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> markSolution(
    String threadId,
    String postId,
  ) async {
    try {
      await _client.markCommunitySolution(id: threadId, postId: postId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> reportPost({
    required String threadId,
    required String postId,
    required String reason,
  }) async {
    try {
      await _client.reportPost(
        id: threadId,
        postId: postId,
        body: ReportPostRequest(reason: reason),
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> reportThread({
    required String threadId,
    required String reason,
  }) async {
    try {
      await _client.reportThread(
        id: threadId,
        body: ReportThreadRequest(reason: reason),
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> reportUser({
    required String threadId,
    required String reportedAccountId,
    required String reason,
  }) async {
    try {
      await _client.reportUser(
        id: threadId,
        body: ReportUserRequest(
          reason: reason,
          reportedAccountId: reportedAccountId,
        ),
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  CommunityFailure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const CommunityFailure.networkError();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        final detail = data is Map<String, dynamic>
            ? data['detail'] as String?
            : null;

        if (statusCode == 404) {
          return const CommunityFailure.notFound();
        } else if (statusCode == 401 || statusCode == 403) {
          return const CommunityFailure.unauthorized();
        } else if (statusCode == 400 || statusCode == 422) {
          return CommunityFailure.invalidData(detail);
        }
        return CommunityFailure.serverError(detail);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const CommunityFailure.serverError();
    }
  }

  DiscussionThread _mapThreadDtoToDomain(
    ThreadDto dto, {
    Map<String, dynamic>? json,
  }) {
    final status = _mapThreadStatus(dto.status);
    final authorUsername = json?['authorUsername'] as String?;
    final authorDisplayName = json?['authorDisplayName'] as String?;
    final authorAvatarUrl = json?['authorAvatarUrl'] as String?;
    final sectorIds = dto.sectorIds?.cast<String>().toList();
    final tagIds = dto.tagIds?.cast<String>().toList();

    return DiscussionThread(
      id: dto.id,
      title: dto.title,
      slug: dto.slug,
      description: dto.description,
      authorId: dto.authorId,
      authorUsername: authorUsername,
      authorDisplayName: authorDisplayName,
      authorAvatarUrl: authorAvatarUrl,
      isPinned: dto.isPinned,
      isFollowed: dto.isFollowed,
      unreadCount: dto.unreadCount,
      status: status,
      viewCount: dto.viewCount,
      shareCount: dto.shareCount,
      replyCount: dto.replyCount,
      sectorIds: sectorIds,
      tagIds: tagIds,
      lastActivityAt: dto.lastActivityAt,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  DiscussionPost _mapPostDtoToDomain(
    PostDto dto, {
    Map<String, dynamic>? json,
  }) {
    final authorUsername = json?['authorUsername'] as String?;
    final authorDisplayName = json?['authorDisplayName'] as String?;
    final authorAvatarUrl = json?['authorAvatarUrl'] as String?;

    final attachments = dto.attachments
        ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
        .toList();

    return DiscussionPost(
      id: dto.id,
      threadId: dto.threadId,
      parentPostId: dto.parentPostId,
      authorId: dto.authorId,
      authorUsername: authorUsername,
      authorDisplayName: authorDisplayName,
      authorAvatarUrl: authorAvatarUrl,
      content: dto.content,
      isSolution: dto.isSolution,
      isPinned: dto.isPinned,
      upvoteCount: dto.upvoteCount,
      attachments: attachments,
      editCount: dto.editCount,
      editedAt: dto.editedAt,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  ThreadStatus _mapThreadStatus(String dtoStatus) {
    switch (dtoStatus.toLowerCase()) {
      case 'locked':
        return ThreadStatus.locked;
      case 'archived':
        return ThreadStatus.archived;
      case 'open':
      default:
        return ThreadStatus.open;
    }
  }
}
