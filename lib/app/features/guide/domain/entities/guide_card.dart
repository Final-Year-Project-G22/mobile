class GuideCard {
  const GuideCard({
    required this.id,
    required this.slug,
    required this.name,
    this.description,
    this.icon,
  });

  final String id;
  final String slug;
  final String name;
  final String? description;
  final String? icon;
}
