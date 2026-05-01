import 'dart:io';

import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../domain/entities/community_category.dart';
import '../domain/entities/discussion_post.dart';
import '../domain/entities/discussion_thread.dart';
import '../domain/failures/community_failure.dart';
import '../domain/i_community_repository.dart';

class CommunityRepositoryImpl implements ICommunityRepository {
  const CommunityRepositoryImpl(this._client);

  final CommunityClient _client;

  @override
  Future<Either<CommunityFailure, List<DiscussionThread>>> listThreads({
    String? categoryId,
    String? search,
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await _client.listAllCommunityThreads(
        categoryId: categoryId,
        search: search,
        page: page,
        pageSize: pageSize,
      );

      final threads = (response.data.threads ?? []).map((e) {
        final json = e as Map<String, dynamic>;
        final dto = ThreadDto.fromJson(json);
        return _mapThreadDtoToDomain(dto, json: json);
      }).toList();

      return Right(threads);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, List<CommunityCategory>>> getCategories({
    int? page,
    int? pageSize,
    String? search,
  }) async {
    try {
      final response = await _client.listCommunityCategories(
        page: page,
        pageSize: pageSize,
        search: search,
      );

      final categories = (response.data.categories ?? [])
          .map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .map(_mapCategoryDtoToDomain)
          .toList();

      return Right(categories);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, List<DiscussionThread>>> getThreadsByCategory(
    String categoryId, {
    int? page,
    int? pageSize,
    String? search,
  }) async {
    try {
      final response = await _client.listCommunityThreads(
        id: categoryId,
        page: page,
        pageSize: pageSize,
        search: search,
      );

      final threads = (response.data.threads ?? []).map((e) {
        final json = e as Map<String, dynamic>;
        final dto = ThreadDto.fromJson(json);
        return _mapThreadDtoToDomain(dto, json: json);
      }).toList();

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
    String? categoryId,
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await _client.searchCommunityThreads(
        keyword: keyword,
        categoryId: categoryId,
        page: page,
        pageSize: pageSize,
      );

      final threads = (response.data.threads ?? []).map((e) {
        final json = e as Map<String, dynamic>;
        final dto = ThreadDto.fromJson(json);
        return _mapThreadDtoToDomain(dto, json: json);
      }).toList();

      return Right(threads);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, String>> createThread({
    required String categoryId,
    required String title,
    required String slug,
    required String description,
    required String initialPostContent,
    String? parentThreadId,
    File? attachment,
  }) async {
    try {
      MultipartFile? multipartFile;
      if (attachment != null) {
        multipartFile = await MultipartFile.fromFile(attachment.path);
      }

      final response = await _client.createCommunityThread(
        categoryId: categoryId,
        title: title,
        slug: slug,
        description: description,
        initialPostContent: initialPostContent,
        parentThreadId: parentThreadId,
        file: multipartFile,
      );

      return Right(response.data.threadId);
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
    File? attachment,
  }) async {
    try {
      MultipartFile? multipartFile;
      if (attachment != null) {
        multipartFile = await MultipartFile.fromFile(attachment.path);
      }

      final response = await _client.createCommunityPost(
        id: threadId,
        content: content,
        file: multipartFile,
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
    File? attachment,
  }) async {
    try {
      MultipartFile? multipartFile;
      if (attachment != null) {
        multipartFile = await MultipartFile.fromFile(attachment.path);
      }

      final response = await _client.replyCommunityPost(
        id: threadId,
        postId: postId,
        content: content,
        file: multipartFile,
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
    bool removeAttachment = false,
    File? attachment,
  }) async {
    try {
      MultipartFile? multipartFile;
      if (attachment != null) {
        multipartFile = await MultipartFile.fromFile(attachment.path);
      }

      await _client.updateCommunityPost(
        id: postId,
        content: content,
        removeAttachment: removeAttachment,
        file: multipartFile,
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
  Future<Either<CommunityFailure, Unit>> followCategory(
    String categoryId,
  ) async {
    try {
      await _client.followCommunityCategory(id: categoryId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(CommunityFailure.serverError());
    }
  }

  @override
  Future<Either<CommunityFailure, Unit>> unfollowCategory(
    String categoryId,
  ) async {
    try {
      await _client.unfollowCommunityCategory(id: categoryId);
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

  CommunityCategory _mapCategoryDtoToDomain(CategoryDto dto) {
    return CommunityCategory(
      id: dto.id,
      name: dto.name,
      slug: dto.slug,
      description: dto.description,
      parentCategoryId: dto.parentCategoryId,
      isActive: dto.isActive,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  DiscussionThread _mapThreadDtoToDomain(
    ThreadDto dto, {
    Map<String, dynamic>? json,
  }) {
    final status = _mapThreadStatus(dto.status);
    final authorUsername = json?['authorUsername'] as String?;
    final authorDisplayName = json?['authorDisplayName'] as String?;
    final authorAvatarUrl = json?['authorAvatarUrl'] as String?;

    return DiscussionThread(
      id: dto.id,
      title: dto.title,
      slug: dto.slug,
      description: dto.description,
      categoryId: dto.categoryId,
      authorId: dto.authorId,
      authorUsername: authorUsername,
      authorDisplayName: authorDisplayName,
      authorAvatarUrl: authorAvatarUrl,
      isPinned: dto.isPinned,
      status: status,
      viewCount: dto.viewCount,
      shareCount: dto.shareCount,
      replyCount: dto.replyCount,
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
      attachmentUrl: dto.attachmentUrl,
      attachmentType: dto.attachmentType,
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
