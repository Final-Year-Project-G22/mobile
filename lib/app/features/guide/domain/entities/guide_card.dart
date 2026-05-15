class GuideCard {
  const GuideCard({
    required this.id,
    required this.slug,
    required this.name,
    this.description,
    this.icon,
    this.sectorIds = const [],
    this.tagIds = const [],
  });

  final String id;
  final String slug;
  final String name;
  final String? description;
  final String? icon;
  final List<String> sectorIds;
  final List<String> tagIds;
}
