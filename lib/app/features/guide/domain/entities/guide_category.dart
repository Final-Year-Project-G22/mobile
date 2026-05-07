import 'guide_card.dart';

class GuideCategory {
  const GuideCategory({
    required this.id,
    required this.slug,
    required this.name,
    required this.sortOrder,
    this.description,
    this.icon,
    this.children = const [],
    this.guides = const [],
  });

  final String id;
  final String slug;
  final String name;
  final int sortOrder;
  final String? description;
  final String? icon;
  final List<GuideCategory> children;
  final List<GuideCard> guides;
}
