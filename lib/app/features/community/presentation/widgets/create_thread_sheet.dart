import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../application/providers/community_data_providers.dart';
import '../../application/providers/community_mutations_provider.dart';
import '../../application/providers/community_state_providers.dart';

class CreateThreadSheet extends ConsumerStatefulWidget {
  const CreateThreadSheet({super.key});

  @override
  ConsumerState<CreateThreadSheet> createState() => _CreateThreadSheetState();
}

class _CreateThreadSheetState extends ConsumerState<CreateThreadSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _initialPostController = TextEditingController();

  String? _selectedCategoryId;
  File? _selectedImage;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = ref.read(selectedCategoryIdProvider);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _initialPostController.dispose();
    super.dispose();
  }

  String _buildSlug(String title) {
    final normalized = title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .trim()
        .replaceAll(RegExp(r'\s+'), '-');
    return '$normalized-${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (picked != null && mounted) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final initialPost = _initialPostController.text.trim();

    final result = await ref
        .read(communityMutationsProvider.notifier)
        .createThread(
          categoryId: _selectedCategoryId!,
          title: title,
          slug: _buildSlug(title),
          description: description,
          initialPostContent: initialPost,
          attachment: _selectedImage,
        );

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $failure')),
        );
      },
      (threadId) {
        ref.read(selectedCategoryIdProvider.notifier).setCategoryId(_selectedCategoryId);

        Navigator.of(context).pop(threadId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomInset + 16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Thread',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 16),

              /// Category dropdown
              categoriesAsync.when(
                data: (categories) {
                  return DropdownButtonFormField<String>(
                    initialValue: categories.any((c) => c.id == _selectedCategoryId) ? _selectedCategoryId : null,
                    hint: const Text('Select category'),
                    items: categories
                        .map(
                          (c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.name),
                          ),
                        )
                        .toList(),
                    onChanged: _isSubmitting ? null : (v) => setState(() => _selectedCategoryId = v),
                    validator: (v) => v == null ? 'Category required' : null,
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text('Error loading categories'),
              ),

              const SizedBox(height: 12),

              /// Title
              TextFormField(
                controller: _titleController,
                enabled: !_isSubmitting,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  final t = v?.trim() ?? '';
                  if (t.isEmpty) return 'Title required';
                  if (t.length < 5) return 'Min 5 chars';
                  return null;
                },
              ),

              const SizedBox(height: 12),

              /// Description
              TextFormField(
                controller: _descriptionController,
                enabled: !_isSubmitting,
                minLines: 2,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Thread Summary',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v?.trim().isEmpty ?? true) ? 'Summary required' : null,
              ),

              const SizedBox(height: 12),

              /// Initial post
              TextFormField(
                controller: _initialPostController,
                enabled: !_isSubmitting,
                minLines: 4,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Initial Post',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v?.trim().isEmpty ?? true) ? 'Post required' : null,
              ),

              const SizedBox(height: 12),

              /// ✅ FIXED ROW (IMPORTANT)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isSubmitting ? null : _pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text('Attach Image'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (_selectedImage != null)
                    Expanded(
                      child: Text(
                        _selectedImage!.path.split('/').last,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              /// Submit button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Post Thread'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
