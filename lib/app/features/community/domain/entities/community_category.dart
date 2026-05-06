import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_category.freezed.dart';

@freezed
abstract class CommunityCategory with _$CommunityCategory {
  const factory CommunityCategory({
    required String id,
    required String name,
    required String slug,
    required bool isActive,
    String? description,
    String? parentCategoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CommunityCategory;
}
