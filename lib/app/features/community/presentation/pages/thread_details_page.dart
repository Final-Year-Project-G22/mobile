import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/application/auth_notifier.dart';
import '../../application/providers/community_data_providers.dart';
import '../../application/providers/community_mutations_provider.dart';
import '../../domain/entities/discussion_post.dart';
import '../../domain/entities/discussion_thread.dart';
import '../widgets/edit_thread_sheet.dart';
import '../widgets/post_card.dart';
import '../widgets/reply_input_bar.dart';
import '../widgets/report_sheet.dart';

class ThreadDetailsPage extends ConsumerStatefulWidget {
  const ThreadDetailsPage({
    required this.threadId,
    required this.threadTitle,
    super.key,
  });

  final String threadId;
  final String threadTitle;

  @override
  ConsumerState<ThreadDetailsPage> createState() => _ThreadDetailsPageState();
}

class _ThreadDetailsPageState extends ConsumerState<ThreadDetailsPage> {
  final _scrollController = ScrollController();
  final _postKeys = <String, GlobalKey>{};
  DiscussionPost? _replyTarget;
  DiscussionPost? _editTarget;
  bool _initialScrollDone = false;
  int? _previousPostCount;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _startReply(DiscussionPost post) {
    setState(() {
      _replyTarget = post;
      _editTarget = null;
    });
  }

  void _scrollToParent(String parentPostId) {
    final key = _postKeys[parentPostId];
    if (key?.currentContext != null) {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then((_) {
          if (key?.currentContext != null) {
            return Scrollable.ensureVisible(
              key!.currentContext!,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              alignment: 0.1,
            );
          }
          return Future<void>.value();
        }),
      );
    }
  }

  void _startEdit(DiscussionPost post) {
    setState(() {
      _editTarget = post;
      _replyTarget = null;
    });
  }

  void _clearMode() {
    setState(() {
      _replyTarget = null;
      _editTarget = null;
    });
    _scrollToBottom();
  }

  String _displayName(String authorId, String? authorDisplayName) {
    if (authorDisplayName != null && authorDisplayName.trim().isNotEmpty) {
      return authorDisplayName;
    }
    final prefix = authorId.length >= 6 ? authorId.substring(0, 6) : authorId;
    return 'User $prefix';
  }

  bool _isAuthor(String authorId, String? currentAccountId) {
    if (currentAccountId == null || currentAccountId.isEmpty) {
      return false;
    }
    return authorId == currentAccountId;
  }

  Future<void> _deletePost(DiscussionPost post) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) {
      return;
    }

    final result = await ref.read(communityMutationsProvider.notifier).deletePost(post.id, widget.threadId);

    if (!mounted) {
      return;
    }

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete: $failure')),
        );
      },
      (_) {
        if (_replyTarget?.id == post.id || _editTarget?.id == post.id) {
          _clearMode();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post deleted successfully')),
        );
      },
    );
  }

  void _reportPost(DiscussionPost post) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => ReportSheet(
          threadId: widget.threadId,
          postId: post.id,
        ),
      ),
    );
  }

  void _reportUser(DiscussionPost post) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => ReportSheet(
          threadId: widget.threadId,
          targetUserId: post.authorId,
          targetUserName: _displayName(post.authorId, post.authorDisplayName),
        ),
      ),
    );
  }

  void _reportThread() {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => ReportSheet(
          threadId: widget.threadId,
        ),
      ),
    );
  }

  Future<void> _editThread(DiscussionThread thread) async {
    final didUpdate = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (_) => EditThreadSheet(thread: thread),
    );

    if (didUpdate == true && mounted) {
      ref.invalidate(threadDetailsProvider(widget.threadId));
    }
  }

  Future<void> _deleteThread(DiscussionThread thread) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Thread'),
        content: const Text('Are you sure you want to delete this thread? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) {
      return;
    }

    final result = await ref.read(communityMutationsProvider.notifier).deleteThread(thread.id);

    if (!mounted) {
      return;
    }

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete: $failure')),
        );
      },
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thread deleted successfully')),
        );
        Navigator.of(context).pop();
      },
    );
  }

  int _nestingLevel(
    DiscussionPost post,
    Map<String, DiscussionPost> postsById,
  ) {
    var level = 0;
    var current = post;

    while (current.parentPostId != null) {
      final parent = postsById[current.parentPostId!];
      if (parent == null) {
        break;
      }
      level += 1;
      current = parent;
      if (level >= 3) {
        break;
      }
    }

    return level;
  }

  List<DiscussionPost> _buildThreadedReplies(
    List<DiscussionPost> source,
    String? rootId,
  ) {
    if (source.isEmpty) {
      return const [];
    }

    final byParent = <String?, List<DiscussionPost>>{};
    for (final post in source) {
      byParent.putIfAbsent(post.parentPostId, () => []).add(post);
    }

    for (final entries in byParent.values) {
      entries.sort(
        (a, b) => (a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0)).compareTo(
          b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        ),
      );
    }

    final ordered = <DiscussionPost>[];

    void addBranch(String? parentId) {
      final children = byParent[parentId] ?? const [];
      for (final child in children) {
        ordered.add(child);
        addBranch(child.id);
      }
    }

    addBranch(rootId);

    if (rootId != null) {
      final remaining = source.where((post) => !ordered.contains(post));
      final leftovers = remaining.toList()
        ..sort(
          (a, b) => (a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0)).compareTo(
            b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
          ),
        );
      ordered.addAll(leftovers);
    }

    return ordered;
  }

  @override
  Widget build(BuildContext context) {
    final threadAsync = ref.watch(threadDetailsProvider(widget.threadId));
    final postsAsync = ref.watch(threadPostsProvider(widget.threadId));
    final authState = ref.watch(authProvider);
    final currentAccountId = authState.asData?.value.account?.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.threadTitle),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final threadAsync = ref.watch(threadDetailsProvider(widget.threadId));

              return threadAsync.when(
                data: (thread) {
                  return IconButton(
                    icon: Icon(
                      thread.isFollowed ? Icons.bookmark : Icons.bookmark_border,
                    ),
                    tooltip: thread.isFollowed ? 'Unfollow thread' : 'Follow thread',
                    onPressed: () async {
                      final notifier = ref.read(communityMutationsProvider.notifier);
                      final result = await (thread.isFollowed
                          ? notifier.unfollowThread(thread.id)
                          : notifier.followThread(thread.id));
                      if (!context.mounted) return;
                      result.fold(
                        (failure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed: $failure')),
                          );
                        },
                        (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                thread.isFollowed
                                    ? 'Unfollowed thread'
                                    : 'Following thread',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (e, s) => const SizedBox.shrink(),
              );
            },
          ),
          Consumer(
            builder: (context, ref, _) {
              final threadAsync = ref.watch(threadDetailsProvider(widget.threadId));
              final authState = ref.watch(authProvider);
              final currentAccountId = authState.asData?.value.account?.id;

              return threadAsync.when(
                data: (thread) {
                  final isAuthor = _isAuthor(thread.authorId, currentAccountId);
                  return PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'report') {
                        _reportThread();
                      } else if (value == 'edit') {
                        unawaited(_editThread(thread));
                      } else if (value == 'delete') {
                        unawaited(_deleteThread(thread));
                      }
                    },
                    itemBuilder: (context) => [
                      if (isAuthor) ...[
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit Thread'),
                        ),
                        if (thread.replyCount == 0)
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              'Delete Thread',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                      const PopupMenuItem(
                        value: 'report',
                        child: Text(
                          'Report Thread',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (e, s) => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: threadAsync.when(
        data: (thread) {
          return postsAsync.when(
            data: (posts) {
              final sortedPosts = [...posts]
                ..sort(
                  (a, b) => (a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0)).compareTo(
                    b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
                  ),
                );

              final postsById = {
                for (final post in sortedPosts) post.id: post,
              };

              DiscussionPost? initialPost;
              for (final post in sortedPosts) {
                if (post.parentPostId == null) {
                  initialPost = post;
                  break;
                }
              }

              final initialPostId = initialPost?.id;
              final repliesSource = initialPostId == null
                  ? sortedPosts
                  : sortedPosts.where((post) => post.id != initialPostId).toList();

              final orderedReplies = _buildThreadedReplies(
                repliesSource,
                initialPostId,
              );

              final currentPostCount = sortedPosts.length;
              if (_previousPostCount != null && currentPostCount > _previousPostCount!) {
                _scrollToBottom();
              }
              _previousPostCount = currentPostCount;

              if (!_initialScrollDone) {
                _initialScrollDone = true;
                if (orderedReplies.isNotEmpty) {
                  _scrollToBottom();
                }
              }

              _postKeys.clear();
              for (final post in orderedReplies) {
                _postKeys.putIfAbsent(post.id, GlobalKey.new);
              }
              if (initialPost != null) {
                _postKeys.putIfAbsent(initialPost.id, GlobalKey.new);
              }

              return ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            if (initialPost != null)
                              PostCard(
                                key: _postKeys[initialPost.id],
                                authorId: initialPost.authorId,
                                authorDisplayName: _displayName(
                                  initialPost.authorId,
                                  initialPost.authorDisplayName,
                                ),
                                authorAvatarUrl: initialPost.authorAvatarUrl,
                                content: initialPost.content,
                                attachments: initialPost.attachments,
                                upvoteCount: initialPost.upvoteCount,
                                createdAt: initialPost.createdAt ?? thread.createdAt,
                                isEdited: initialPost.editCount > 0 || initialPost.editedAt != null,
                                onReply: () => _startReply(initialPost!),
                                onEdit:
                                    _isAuthor(
                                      initialPost.authorId,
                                      currentAccountId,
                                    )
                                    ? () => _startEdit(initialPost!)
                                    : null,
                                onDelete:
                                    _isAuthor(
                                      initialPost.authorId,
                                      currentAccountId,
                                    )
                                    ? () => _deletePost(initialPost!)
                                    : null,
                                onReport:
                                    _isAuthor(
                                      initialPost.authorId,
                                      currentAccountId,
                                    )
                                    ? null
                                    : () => _reportPost(initialPost!),
                                onReportUser:
                                    _isAuthor(
                                      initialPost.authorId,
                                      currentAccountId,
                                    )
                                    ? null
                                    : () => _reportUser(initialPost!),
                              )
                            else if (thread.description != null && thread.description!.isNotEmpty)
                              PostCard(
                                authorId: thread.authorId,
                                authorDisplayName: _displayName(
                                  thread.authorId,
                                  thread.authorDisplayName,
                                ),
                                authorAvatarUrl: thread.authorAvatarUrl,
                                content: thread.description!,
                                createdAt: thread.createdAt,
                              ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                    if (orderedReplies.isEmpty)
                      const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: Text('No replies yet. Be the first!'),
                          ),
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final post = orderedReplies[index];
                            final parent = post.parentPostId == null ? null : postsById[post.parentPostId!];
                            final parentPreview = parent == null
                                ? null
                                : 'Replying to ${_displayName(parent.authorId, parent.authorDisplayName)}: ${parent.content}';
                            final parentPostId = post.parentPostId;

                            return PostCard(
                              key: _postKeys[post.id],
                              authorId: post.authorId,
                              authorDisplayName: _displayName(
                                post.authorId,
                                post.authorDisplayName,
                              ),
                              authorAvatarUrl: post.authorAvatarUrl,
                              content: post.content,
                              upvoteCount: post.upvoteCount,
                              attachments: post.attachments,
                              nestingLevel: _nestingLevel(post, postsById),
                              parentPreview: parentPreview,
                              onParentPreviewTap: parentPostId != null ? () => _scrollToParent(parentPostId) : null,
                              createdAt: post.createdAt ?? thread.createdAt,
                              isEdited: post.editCount > 0 || post.editedAt != null,
                              onReply: () => _startReply(post),
                              onEdit: _isAuthor(post.authorId, currentAccountId) ? () => _startEdit(post) : null,
                              onDelete: _isAuthor(post.authorId, currentAccountId) ? () => _deletePost(post) : null,
                              onReport: _isAuthor(post.authorId, currentAccountId) ? null : () => _reportPost(post),
                              onReportUser: _isAuthor(post.authorId, currentAccountId) ? null : () => _reportUser(post),
                            );
                          },
                          childCount: orderedReplies.length,
                        ),
                      ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Text('Error loading posts: $error'),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error loading thread: $error'),
        ),
      ),
      bottomNavigationBar: ReplyInputBar(
        threadId: widget.threadId,
        replyTarget: _replyTarget,
        editTarget: _editTarget,
        onClearMode: _clearMode,
      ),
    );
  }
}
