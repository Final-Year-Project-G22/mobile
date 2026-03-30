import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tab_notifier.g.dart';

enum HomeTab { guide, community, aiGuild, templates }

class HomeTabSpec {
  const HomeTabSpec({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

const List<HomeTabSpec> homeTabSpecs = [
  HomeTabSpec(
    label: 'Guide',
    icon: Icons.menu_book_outlined,
    selectedIcon: Icons.menu_book,
  ),
  HomeTabSpec(
    label: 'Community',
    icon: Icons.groups_outlined,
    selectedIcon: Icons.groups,
  ),
  HomeTabSpec(
    label: 'AI Guide',
    icon: Icons.auto_awesome_outlined,
    selectedIcon: Icons.auto_awesome,
  ),
  HomeTabSpec(
    label: 'Templates',
    icon: Icons.grid_view_outlined,
    selectedIcon: Icons.grid_view,
  ),
];

@riverpod
class HomeTabIndex extends _$HomeTabIndex {
  @override
  int build() => 0;

  void setIndex(int index) {
    if (index < 0 || index >= homeTabSpecs.length) return;
    state = index;
  }
}
