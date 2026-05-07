import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers/templates_data_providers.dart';
import '../../application/providers/templates_list_notifier.dart';
import '../widgets/category_drawer.dart';
import '../widgets/template_card.dart';

class TemplatesListPage extends ConsumerStatefulWidget {
  const TemplatesListPage({super.key});

  @override
  ConsumerState<TemplatesListPage> createState() => _TemplatesListPageState();
}

class _TemplatesListPageState extends ConsumerState<TemplatesListPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(() {
      final hasText = _searchController.text.isNotEmpty;
      if (_showClear != hasText) {
        setState(() => _showClear = hasText);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(templateListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(templateListProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_done),
            onPressed: () => context.push('/downloads'),
            tooltip: 'My Downloads',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search templates...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _showClear
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _showClear = false);
                          ref
                              .read(templateListProvider.notifier)
                              .setSearch(null);
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                ref
                    .read(templateListProvider.notifier)
                    .setSearch(value.isEmpty ? null : value);
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Category chips
          categoriesAsync.when(
            data: (categories) {
              if (categories.isEmpty) return const SizedBox.shrink();

              return SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: categories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ActionChip(
                          avatar: const Icon(Icons.category_outlined, size: 18),
                          label: const Text('All'),
                          onPressed: () => _showCategoryDrawer(categories),
                        ),
                      );
                    }

                    final category = categories[index - 1];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        label: Text(category.name),
                        onSelected: (_) {
                          ref
                              .read(templateListProvider.notifier)
                              .setCategory(category.id);
                        },
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const SizedBox(
              height: 50,
              child: Center(child: LinearProgressIndicator()),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Template grid
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await ref
                    .read(templateListProvider.notifier)
                    .refresh();
              },
              child: listAsync.when(
                data: (state) {
                  if (state.items.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_open, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('No templates found'),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount:
                        state.items.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.items.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final template = state.items[index];
                      return TemplateCard(
                        template: template,
                        onTap: () =>
                            context.push('/templates/${template.id}'),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCategoryDrawer(List<dynamic> categories) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => CategoryDrawer(
        categories: categories,
        onSelect: (categoryId) {
          Navigator.pop(context);
          ref
              .read(templateListProvider.notifier)
              .setCategory(categoryId);
        },
      ),
    );
  }
}
