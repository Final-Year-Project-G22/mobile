import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/auth_providers.dart';
import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../core/providers/websocket_providers.dart';
import '../../../../../core/services/websocket_service.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../../shared/widgets/empty_state_view.dart';
import '../../../../../shared/widgets/error_view.dart';
import '../../../../constants/app_spacing.dart';
import '../../application/providers/community_data_providers.dart';
import '../../application/providers/community_mutations_provider.dart';
import '../../domain/entities/discussion_post.dart';
import '../../domain/entities/discussion_thread.dart';
import '../widgets/post_card.dart';
import '../widgets/reply_input_bar.dart';
import '../widgets/report_sheet.dart';
import 'edit_thread_page.dart';

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
  bool _markReadDone = false;
  bool _isScrolling = false;
  bool _pendingScroll = false;
  int? _previousPostCount;
  late final WebSocketService _webSocketService;

  @override
  void initState() {
    super.initState();
    _webSocketService = ref.read(webSocketServiceProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _webSocketService.subscribeThread(widget.threadId);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _webSocketService.unsubscribeThread(widget.threadId);
    super.dispose();
  }

  void _scrollToBottom() {
    if (_isScrolling) {
      _pendingScroll = true;
      return;
    }
    _isScrolling = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.position.maxScrollExtent > 0) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      }
      _isScrolling = false;
      if (_pendingScroll) {
        _pendingScroll = false;
        _scrollToBottom();
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
              duration: AppSpacing.durationMedium2,
              curve: AppSpacing.curveEaseOut,
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

  Future<void> _deletePost(DiscussionPost post, AppLocalizations l10n) async {
    final theme = Theme.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deletePost),
        content: Text(l10n.confirmDeletePost),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.delete,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) {
      return;
    }

    final result = await ref
        .read(communityMutationsProvider.notifier)
        .deletePost(post.id, widget.threadId);

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
          SnackBar(content: Text(l10n.postDeleted)),
        );
      },
    );
  }

  Future<void> _markSolution(DiscussionPost post, AppLocalizations l10n) async {
    final theme = Theme.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.markAsSolution),
        content: Text(l10n.confirmMarkSolution),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.mark,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    final result = await ref
        .read(communityMutationsProvider.notifier)
        .markSolution(
          widget.threadId,
          post.id,
        );
    if (!mounted) return;

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to mark solution: $failure')),
        );
      },
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.markedAsSolution)),
        );
      },
    );
  }

  void _reportPost(DiscussionPost post) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
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
        useSafeArea: true,
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
        useSafeArea: true,
        builder: (_) => ReportSheet(
          threadId: widget.threadId,
        ),
      ),
    );
  }

  Future<void> _editThread(DiscussionThread thread) async {
    final didUpdate = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => EditThreadPage(thread: thread),
      ),
    );

    if (didUpdate == true && mounted) {
      ref.invalidate(threadDetailsProvider(widget.threadId));
    }
  }

  Future<void> _deleteThread(
    DiscussionThread thread,
    AppLocalizations l10n,
  ) async {
    final theme = Theme.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteThread),
        content: Text(l10n.confirmDeleteThread),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.delete,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) {
      return;
    }

    final result = await ref
        .read(communityMutationsProvider.notifier)
        .deleteThread(thread.id);

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
          SnackBar(content: Text(l10n.threadDeleted)),
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
        (a, b) =>
            (a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0)).compareTo(
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
          (a, b) =>
              (a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0)).compareTo(
                b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
              ),
        );
      ordered.addAll(leftovers);
    }

    return ordered;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final threadAsync = ref.watch(threadDetailsProvider(widget.threadId));
    final postsAsync = ref.watch(threadPostsProvider(widget.threadId));
    final currentAccountId = ref.watch(currentAccountIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.threadTitle),
        actions: [
          if (_isAuthor(
            threadAsync.asData?.value.authorId ?? '',
            currentAccountId,
          ))
            const SizedBox.shrink()
          else
            Consumer(
              builder: (context, ref, _) {
                final threadAsync = ref.watch(
                  threadDetailsProvider(widget.threadId),
                );

                return threadAsync.when(
                  data: (thread) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            thread.isFollowed
                                ? Icons.notifications
                                : Icons.notifications_none,
                          ),
                          tooltip: thread.isFollowed
                              ? l10n.unfollowThread
                              : l10n.followThread,
                          onPressed: () async {
                            final notifier = ref.read(
                              communityMutationsProvider.notifier,
                            );
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
                                          ? l10n.unfollowedThread
                                          : l10n.followingThread,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            thread.isMuted
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          tooltip: thread.isMuted
                              ? 'Unmute Thread'
                              : 'Mute Thread',
                          onPressed: () async {
                            final notifier = ref.read(
                              communityMutationsProvider.notifier,
                            );
                            final result = await (thread.isMuted
                                ? notifier.unmuteThread(thread.id)
                                : notifier.muteThread(thread.id));
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
                                      thread.isMuted
                                          ? 'Thread unmuted'
                                          : 'Thread muted',
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (e, s) => const SizedBox.shrink(),
                );
              },
            ),
          Consumer(
            builder: (context, ref, _) {
              final threadAsync = ref.watch(
                threadDetailsProvider(widget.threadId),
              );
              final currentAccountId = ref.watch(currentAccountIdProvider);

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
                        unawaited(_deleteThread(thread, l10n));
                      }
                    },
                    itemBuilder: (context) => [
                      if (isAuthor) ...[
                        PopupMenuItem(
                          value: 'edit',
                          child: Text(l10n.editThread),
                        ),
                        if (thread.replyCount == 0)
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              l10n.deleteThread,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                      if (!isAuthor)
                        PopupMenuItem(
                          value: 'report',
                          child: Text(
                            l10n.reportThread,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.error,
                            ),
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
          if (!_markReadDone && thread.unreadCount > 0) {
            _markReadDone = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              unawaited(
                ref
                    .read(communityMutationsProvider.notifier)
                    .markThreadRead(thread.id),
              );
            });
          }
          return postsAsync.when(
            data: (posts) {
              final sortedPosts = [...posts]
                ..sort(
                  (a, b) =>
                      (a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0))
                          .compareTo(
                            b.createdAt ??
                                DateTime.fromMillisecondsSinceEpoch(0),
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
                  : sortedPosts
                        .where((post) => post.id != initialPostId)
                        .toList();

              final orderedReplies = _buildThreadedReplies(
                repliesSource,
                initialPostId,
              );

              final currentPostCount = sortedPosts.length;
              if (_previousPostCount != null &&
                  currentPostCount > _previousPostCount!) {
                _scrollToBottom();
                if (_previousPostCount! > 0) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    unawaited(
                      ref
                          .read(communityMutationsProvider.notifier)
                          .markThreadRead(widget.threadId),
                    );
                  });
                }
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
                behavior: ScrollConfiguration.of(
                  context,
                ).copyWith(scrollbars: false),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: AppSpacing.xs,
                          bottom: AppSpacing.xs,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppSpacing.xs),
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
                                createdAt:
                                    initialPost.createdAt ?? thread.createdAt,
                                isEdited:
                                    initialPost.editCount > 0 ||
                                    initialPost.editedAt != null,
                                isSolution: initialPost.isSolution,
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
                                    ? () => _deletePost(initialPost!, l10n)
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
                                onMarkSolution:
                                    _isAuthor(
                                          thread.authorId,
                                          currentAccountId,
                                        ) &&
                                        !initialPost.isSolution
                                    ? () => _markSolution(initialPost!, l10n)
                                    : null,
                              )
                            else if (thread.description != null &&
                                thread.description!.isNotEmpty)
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
                            const Divider(height: 1),
                          ],
                        ),
                      ),
                    ),
                    if (orderedReplies.isEmpty)
                      SliverToBoxAdapter(
                        child: EmptyStateView(
                          icon: Icons.forum_outlined,
                          title: l10n.noRepliesYet,
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final post = orderedReplies[index];
                            final parent = post.parentPostId == null
                                ? null
                                : postsById[post.parentPostId!];
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
                              onParentPreviewTap: parentPostId != null
                                  ? () => _scrollToParent(parentPostId)
                                  : null,
                              createdAt: post.createdAt ?? thread.createdAt,
                              isEdited:
                                  post.editCount > 0 || post.editedAt != null,
                              isSolution: post.isSolution,
                              onReply: () => _startReply(post),
                              onEdit: _isAuthor(post.authorId, currentAccountId)
                                  ? () => _startEdit(post)
                                  : null,
                              onDelete:
                                  _isAuthor(post.authorId, currentAccountId)
                                  ? () => _deletePost(post, l10n)
                                  : null,
                              onReport:
                                  _isAuthor(post.authorId, currentAccountId)
                                  ? null
                                  : () => _reportPost(post),
                              onReportUser:
                                  _isAuthor(post.authorId, currentAccountId)
                                  ? null
                                  : () => _reportUser(post),
                              onMarkSolution:
                                  _isAuthor(
                                        thread.authorId,
                                        currentAccountId,
                                      ) &&
                                      !post.isSolution
                                  ? () => _markSolution(post, l10n)
                                  : null,
                            );
                          },
                          childCount: orderedReplies.length,
                        ),
                      ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: AdisuProgressIndicator()),
            error: (error, stackTrace) => ErrorView.inline(
              message: l10n.errorLoadingThreads(error.toString()),
              retryLabel: l10n.retry,
              onRetry: () =>
                  ref.invalidate(threadPostsProvider(widget.threadId)),
            ),
          );
        },
        loading: () => const Center(child: AdisuProgressIndicator()),
        error: (error, stackTrace) => ErrorView(
          message: l10n.errorLoadingThreads(error.toString()),
          retryLabel: l10n.retry,
          onRetry: () => ref.invalidate(threadDetailsProvider(widget.threadId)),
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
