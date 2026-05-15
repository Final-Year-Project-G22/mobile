// These types are from our own api_client package.
// ignore_for_file: implementation_imports

import 'package:api_client/src/api/guides/guides_client.dart';
import 'package:api_client/src/api/models/bookmark_with_step_dto.dart';
import 'package:api_client/src/api/models/complete_step_request.dart';
import 'package:api_client/src/api/models/guide_card_dto.dart';
import 'package:api_client/src/api/models/guide_with_progress_dto.dart';
import 'package:api_client/src/api/models/personalized_step_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../domain/entities/completion_stats.dart';
import '../domain/entities/guide_card.dart';
import '../domain/entities/guide_detail.dart';
import '../domain/entities/guide_step.dart';
import '../domain/entities/guide_with_progress.dart';
import '../domain/entities/step_bookmark.dart';
import '../domain/entities/step_enums.dart';
import '../domain/failures/guide_failures.dart';
import '../domain/i_guide_repository.dart';

class GuideRepositoryImpl implements IGuideRepository {
  const GuideRepositoryImpl(this._client);

  final GuidesClient _client;

  @override
  Future<Either<GuideFailure, List<GuideCard>>> searchGuides(
    String query,
    String? locale,
  ) async {
    try {
      final response = await _client.searchGuides(
        q: query.isEmpty ? null : query,
        locale: locale,
      );
      final raw = response.data.guides;
      if (raw == null) return const Right([]);
      final cards = <GuideCard>[];
      for (final item in raw) {
        if (item is Map<String, dynamic>) {
          final dto = GuideCardDto.fromJson(item);
          cards.add(_mapGuideCard(dto));
        }
      }
      return Right(cards);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<GuideFailure, List<GuideCard>>> getRecentlyViewed(
    String? locale,
  ) async {
    try {
      final response = await _client.getRecentlyViewed(locale: locale);
      final raw = response.data.guides;
      if (raw == null) return const Right([]);
      final cards = <GuideCard>[];
      for (final item in raw) {
        if (item is Map<String, dynamic>) {
          final dto = GuideCardDto.fromJson(item);
          cards.add(_mapGuideCard(dto));
        }
      }
      return Right(cards);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<GuideFailure, GuideDetail>> getPersonalizedGuide(
    String guideSlug,
    String? locale,
  ) async {
    try {
      final response = await _client.getPersonalizedGuide(
        guideSlug: guideSlug,
        locale: locale,
      );
      final data = response.data;

      final steps = <GuideStep>[];
      if (data.steps != null) {
        for (final item in data.steps!) {
          if (item is Map<String, dynamic>) {
            final dto = PersonalizedStepDto.fromJson(item);
            steps.add(_mapStep(dto));
          }
        }
      }

      steps.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

      final hasAnyProgress = steps.any(
        (s) =>
            s.status == StepStatus.completed ||
            s.status == StepStatus.inProgress ||
            s.status == StepStatus.skipped,
      );
      if (!hasAnyProgress && steps.isNotEmpty) {
        final first = steps[0];
        steps[0] = GuideStep(
          id: first.id,
          slug: first.slug,
          title: first.title,
          stepType: first.stepType,
          sortOrder: first.sortOrder,
          status: StepStatus.inProgress,
          description: first.description,
          isOptional: first.isOptional,
          estimatedTime: first.estimatedTime,
          detailedContent: first.detailedContent,
        );
      } else {
        for (var i = 0; i < steps.length; i++) {
          if (steps[i].status == StepStatus.locked) {
            final prev = i > 0 ? steps[i - 1] : null;
            if (prev == null ||
                prev.status == StepStatus.completed ||
                prev.status == StepStatus.skipped) {
              final s = steps[i];
              steps[i] = GuideStep(
                id: s.id,
                slug: s.slug,
                title: s.title,
                stepType: s.stepType,
                sortOrder: s.sortOrder,
                status: StepStatus.inProgress,
                description: s.description,
                isOptional: s.isOptional,
                estimatedTime: s.estimatedTime,
                detailedContent: s.detailedContent,
              );
              break;
            }
          }
        }
      }

      final completed = steps
          .where((s) => s.status == StepStatus.completed)
          .length;
      final skipped = steps.where((s) => s.status == StepStatus.skipped).length;
      final inProgress = steps
          .where((s) => s.status == StepStatus.inProgress)
          .length;

      return Right(
        GuideDetail(
          id: data.id,
          slug: data.slug,
          name: data.name,
          description: data.description,
          steps: steps,
          progress: GuideProgressSummary(
            totalSteps: data.progress?.totalSteps ?? steps.length,
            completedSteps: data.progress?.completedSteps ?? completed,
            skippedSteps: data.progress?.skippedSteps ?? skipped,
            inProgressSteps: data.progress?.inProgressSteps ?? inProgress,
          ),
        ),
      );
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<GuideFailure, List<GuideWithProgress>>>
  getInProgressGuides() async {
    try {
      final response = await _client.getInProgressGuides();
      final raw = response.data.guides;
      if (raw == null) return const Right([]);
      final guides = <GuideWithProgress>[];
      for (final item in raw) {
        if (item is Map<String, dynamic>) {
          final dto = GuideWithProgressDto.fromJson(item);
          guides.add(
            GuideWithProgress(
              id: dto.id,
              slug: dto.slug,
              name: dto.name,
              icon: dto.icon,
              completedSteps: dto.completedSteps,
              totalSteps: dto.totalSteps,
            ),
          );
        }
      }
      return Right(guides);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<GuideFailure, CompletionStats>> getCompletionStats() async {
    try {
      final response = await _client.getCompletionStats();
      final dto = response.data;
      return Right(
        CompletionStats(
          completedGuides: dto.completedGuides,
          inProgressGuides: dto.inProgressGuides,
          totalStepsCompleted: dto.totalStepsCompleted,
          totalStepsAll: dto.totalStepsAll,
          period: dto.period,
        ),
      );
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<GuideFailure, Unit>> startStep(String stepId) async {
    try {
      await _client.startStep(stepId: stepId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<GuideFailure, Unit>> completeStep(String stepId) async {
    try {
      await _client.completeStep(
        stepId: stepId,
        body: const CompleteStepRequest(),
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<GuideFailure, Unit>> skipStep(String stepId) async {
    try {
      await _client.skipOptionalStep(stepId: stepId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<GuideFailure, Unit>> markStepIncomplete(String stepId) async {
    try {
      await _client.markStepIncomplete(stepId: stepId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<GuideFailure, Unit>> addBookmark(String stepId) async {
    try {
      await _client.addBookmark(stepId: stepId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<GuideFailure, Unit>> removeBookmark(String stepId) async {
    try {
      await _client.removeBookmark(stepId: stepId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<GuideFailure, List<StepBookmark>>> listBookmarks() async {
    try {
      final response = await _client.listBookmarks();
      final raw = response.data.bookmarks;
      if (raw == null) return const Right([]);
      final bookmarks = <StepBookmark>[];
      for (final item in raw) {
        if (item is Map<String, dynamic>) {
          final dto = BookmarkWithStepDto.fromJson(item);
          bookmarks.add(
            StepBookmark(
              id: dto.id,
              stepId: dto.stepId,
              stepTitle: dto.stepTitle,
              guideName: dto.guideName,
              note: dto.note,
              createdAt: dto.createdAt,
            ),
          );
        }
      }
      return Right(bookmarks);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  GuideCard _mapGuideCard(GuideCardDto dto) {
    return GuideCard(
      id: dto.id,
      slug: dto.slug,
      name: dto.name,
      description: dto.description,
      icon: dto.icon,
      sectorIds: (dto.sectorIds ?? []).map((e) => e.toString()).toList(),
      tagIds: (dto.tagIds ?? []).map((e) => e.toString()).toList(),
    );
  }

  GuideStep _mapStep(PersonalizedStepDto dto) {
    return GuideStep(
      id: dto.id,
      slug: dto.slug,
      title: dto.title,
      stepType: _mapStepType(dto.stepType),
      sortOrder: dto.sortOrder,
      status: _mapStatus(dto.status),
      description: dto.description,
      isOptional: dto.isOptional,
      estimatedTime: dto.estimatedTime,
    );
  }

  StepType _mapStepType(String type) {
    switch (type.toUpperCase()) {
      case 'INFORMATIONAL':
      case 'STARTUP':
        return StepType.informational;
      case 'ACTION_REQUIRED':
      case 'ACTION':
        return StepType.actionRequired;
      case 'DOCUMENT_SUBMISSION':
      case 'DOCUMENT':
        return StepType.documentSubmission;
      case 'VERIFICATION':
        return StepType.verification;
      default:
        return StepType.informational;
    }
  }

  StepStatus _mapStatus(String status) {
    switch (status.toUpperCase()) {
      case 'IN_PROGRESS':
        return StepStatus.inProgress;
      case 'COMPLETED':
        return StepStatus.completed;
      case 'SKIPPED':
        return StepStatus.skipped;
      case 'LOCKED':
        return StepStatus.locked;
      default:
        return StepStatus.locked;
    }
  }

  GuideFailure _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const GuideFailure.networkError();
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) return const GuideFailure.unauthorized();
        if (statusCode == 404) return const GuideFailure.notFound();
        if (statusCode == 409) {
          final data = e.response?.data;
          final detail = data is Map<String, dynamic>
              ? data['detail'] as String?
              : null;
          return GuideFailure.conflict(message: detail);
        }
        return const GuideFailure.serverError();
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const GuideFailure.serverError();
    }
  }
}
