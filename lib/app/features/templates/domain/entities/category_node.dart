import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_node.freezed.dart';

@freezed
abstract class CategoryNode with _$CategoryNode {
  const factory CategoryNode({
    required String id,
    required String name,
    required String slug,
    required int sortOrder,
    String? icon,
    @Default(<CategoryNode>[]) List<CategoryNode> children,
  }) = _CategoryNode;
}
