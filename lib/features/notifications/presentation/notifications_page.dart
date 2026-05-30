import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../app/theme.dart';
import '../../../core/utils/date_time_formatters.dart';
import '../../../core/utils/error_messages.dart';
import '../../../shared/models/app_models.dart';
import '../../../shared/models/status_labels.dart';
import '../../../shared/widgets/async_state_view.dart';
import '../../../shared/widgets/info_widgets.dart';
import '../../../shared/widgets/screen_scaffold.dart';
import '../../../shared/widgets/webcal_card.dart';
import '../data/notification_repository.dart';

const _notificationTypes = ['', 'FINANCIAL', 'SYSTEM', 'BLOG'];
const _notificationReadStatuses = <int?>[null, 0, 1];

void _invalidateNotificationLists(WidgetRef ref) {
  for (final type in _notificationTypes) {
    for (final readStatus in _notificationReadStatuses) {
      ref.invalidate(
        notificationsProvider((readStatus: readStatus, type: type)),
      );
    }
  }
}

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  int? _readStatus;
  String _type = '';
  final _moreItems = <NotificationItem>[];
  int _loadedMorePages = 0;
  int _pagingVersion = 0;
  bool _loadingMore = false;
  bool _markingAll = false;
  bool _reachedEnd = false;
  String? _loadMoreError;

  NotificationFilter get _filter => (readStatus: _readStatus, type: _type);

  void _clearPaging() {
    _pagingVersion += 1;
    _moreItems.clear();
    _loadedMorePages = 0;
    _loadingMore = false;
    _reachedEnd = false;
    _loadMoreError = null;
  }

  void _refresh() {
    setState(_clearPaging);
    ref.invalidate(notificationsProvider(_filter));
  }

  void _changeReadStatus(int? value) {
    if (_readStatus == value) {
      return;
    }
    setState(() {
      _readStatus = value;
      _clearPaging();
    });
  }

  void _changeType(String value) {
    if (_type == value) {
      return;
    }
    setState(() {
      _type = value;
      _clearPaging();
    });
  }

  Future<void> _loadMore(PageResult<NotificationItem> page) async {
    if (_loadingMore || _reachedEnd) {
      return;
    }
    final requestFilter = _filter;
    final requestVersion = _pagingVersion;
    setState(() {
      _loadingMore = true;
      _loadMoreError = null;
    });
    try {
      final nextPage = await ref
          .read(notificationRepositoryProvider)
          .list(
            readStatus: requestFilter.readStatus,
            type: requestFilter.type,
            pageNo: page.pageNo + _loadedMorePages + 1,
          );
      if (!mounted ||
          requestFilter != _filter ||
          requestVersion != _pagingVersion) {
        return;
      }
      setState(() {
        final totalVisible =
            page.records.length + _moreItems.length + nextPage.records.length;
        _moreItems.addAll(nextPage.records);
        _loadedMorePages += 1;
        _reachedEnd =
            nextPage.records.isEmpty || totalVisible >= nextPage.total;
      });
    } catch (error) {
      if (mounted &&
          requestFilter == _filter &&
          requestVersion == _pagingVersion) {
        setState(() => _loadMoreError = friendlyErrorMessage(error));
      }
    } finally {
      if (mounted &&
          requestFilter == _filter &&
          requestVersion == _pagingVersion) {
        setState(() => _loadingMore = false);
      }
    }
  }

  Future<void> _markAllRead() async {
    if (_markingAll) {
      return;
    }
    setState(() => _markingAll = true);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('全部标记已读'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('将当前账号的未读通知全部标记为已读。'),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('返回'),
            ),
            const SizedBox(height: AppSpacing.sm),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(LucideIcons.checkCheck),
              label: const Text('确认标记'),
            ),
          ],
        ),
      ),
    );
    if (!mounted) {
      return;
    }
    if (confirmed != true) {
      setState(() => _markingAll = false);
      return;
    }
    try {
      final count = await ref
          .read(notificationRepositoryProvider)
          .markAllRead();
      if (!mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: Text(count > 0 ? '已标记 $count 条通知' : '没有新的未读通知'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      _invalidateNotificationLists(ref);
      _refresh();
    } catch (error) {
      if (!mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: Text(friendlyErrorMessage(error)),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } finally {
      if (mounted) {
        setState(() => _markingAll = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = ref.watch(notificationsProvider(_filter));

    return ScreenScaffold(
      title: '通知中心',
      actions: [
        IconButton(
          onPressed: _markingAll ? null : _markAllRead,
          icon: _markingAll
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(LucideIcons.checkCheck),
          tooltip: '全部已读',
        ),
      ],
      onRefresh: _refresh,
      children: [
        _NotificationFilters(
          readStatus: _readStatus,
          type: _type,
          onReadStatusChanged: _changeReadStatus,
          onTypeChanged: _changeType,
        ),
        const SizedBox(height: AppSpacing.md),
        AsyncStateView(
          value: page,
          onRetry: _refresh,
          builder: (data) {
            final records = [...data.records, ..._moreItems];
            final hasMore = !_reachedEnd && records.length < data.total;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _NotificationSummary(
                  total: data.total,
                  visibleCount: records.length,
                  readStatus: _readStatus,
                  type: _type,
                ),
                const SizedBox(height: AppSpacing.md),
                if (records.isEmpty)
                  EmptyCard(
                    title: '暂无通知',
                    subtitle: _emptySubtitle(_readStatus, _type),
                    icon: LucideIcons.mailOpen,
                  )
                else ...[
                  for (final item in records)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: _NotificationCard(item: item),
                    ),
                  if (_loadMoreError != null) ...[
                    ErrorCard(
                      message: _loadMoreError!,
                      onRetry: () => _loadMore(data),
                    ),
                  ] else if (hasMore) ...[
                    OutlinedButton.icon(
                      onPressed: _loadingMore ? null : () => _loadMore(data),
                      icon: _loadingMore
                          ? const SizedBox.square(
                              dimension: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(LucideIcons.chevronsDown),
                      label: Text(_loadingMore ? '加载中...' : '加载更多'),
                    ),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sm),
                      child: Text(
                        '已显示全部通知',
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                      ),
                    ),
                  ],
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class NotificationDetailPage extends ConsumerStatefulWidget {
  const NotificationDetailPage({super.key, required this.id});

  final int id;

  @override
  ConsumerState<NotificationDetailPage> createState() =>
      _NotificationDetailPageState();
}

class _NotificationDetailPageState
    extends ConsumerState<NotificationDetailPage> {
  bool _markingRead = false;

  Future<void> _markRead() async {
    if (_markingRead) {
      return;
    }
    setState(() => _markingRead = true);
    try {
      await ref.read(notificationRepositoryProvider).markRead(widget.id);
      if (!mounted) {
        return;
      }
      ref.invalidate(notificationDetailProvider(widget.id));
      _invalidateNotificationLists(ref);
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('已标记为已读'),
        autoCloseDuration: const Duration(seconds: 2),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: Text(friendlyErrorMessage(error)),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } finally {
      if (mounted) {
        setState(() => _markingRead = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.id;
    if (id <= 0) {
      return const ScreenScaffold(
        title: '通知详情',
        children: [EmptyCard(title: '通知不存在', subtitle: '请返回通知中心重新选择')],
      );
    }

    final detail = ref.watch(notificationDetailProvider(id));

    return ScreenScaffold(
      title: '通知详情',
      onRefresh: () => ref.invalidate(notificationDetailProvider(id)),
      children: [
        AsyncStateView(
          value: detail,
          onRetry: () => ref.invalidate(notificationDetailProvider(id)),
          builder: (item) => _NotificationDetailContent(
            item: item,
            markingRead: _markingRead,
            onMarkRead: item.readStatus == 0 ? _markRead : null,
          ),
        ),
      ],
    );
  }
}

class _NotificationDetailContent extends StatelessWidget {
  const _NotificationDetailContent({
    required this.item,
    required this.markingRead,
    required this.onMarkRead,
  });

  final NotificationItem item;
  final bool markingRead;
  final VoidCallback? onMarkRead;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NotificationIcon(readStatus: item.readStatus),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _textOrDefault(item.title, '通知'),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        height: 1.18,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: [
                        StatusPill(label: _readLabel(item.readStatus)),
                        StatusPill(
                          label: StatusLabels.of(
                            StatusLabels.notificationType,
                            item.type,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SelectableText(
            _textOrDefault(item.content, '暂无正文'),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: AppColors.deepForest,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          InfoRow(
            label: '通知时间',
            value: DateTimeFormatters.compact(item.createdAt),
          ),
          if (item.bizType != null && item.bizType!.isNotEmpty)
            InfoRow(
              label: '关联业务',
              value: StatusLabels.of(
                StatusLabels.notificationBizType,
                item.bizType,
              ),
            ),
          InfoRow(
            label: '阅读时间',
            value: DateTimeFormatters.compact(item.readAt),
          ),
          if (item.localeFallback == true) ...[
            const SizedBox(height: AppSpacing.md),
            const InlineNotice(message: '当前通知已按可用语言展示。'),
          ],
          if (onMarkRead != null) ...[
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: markingRead ? null : onMarkRead,
              icon: markingRead
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(LucideIcons.check),
              label: Text(markingRead ? '标记中...' : '标记已读'),
            ),
          ],
        ],
      ),
    );
  }
}

class _NotificationSummary extends StatelessWidget {
  const _NotificationSummary({
    required this.total,
    required this.visibleCount,
    required this.readStatus,
    required this.type,
  });

  final int total;
  final int visibleCount;
  final int? readStatus;
  final String type;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.deepForest,
              borderRadius: BorderRadius.circular(AppRadii.lg),
            ),
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Icon(
                LucideIcons.inbox,
                color: AppColors.electricGreen,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _activeFilterLabel(readStatus, type),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '共 $total 条，当前显示 $visibleCount 条',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationFilters extends StatelessWidget {
  const _NotificationFilters({
    required this.readStatus,
    required this.type,
    required this.onReadStatusChanged,
    required this.onTypeChanged,
  });

  final int? readStatus;
  final String type;
  final ValueChanged<int?> onReadStatusChanged;
  final ValueChanged<String> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('状态', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              ChoiceChip(
                selected: readStatus == null,
                label: const Text('全部'),
                onSelected: (_) => onReadStatusChanged(null),
              ),
              ChoiceChip(
                selected: readStatus == 0,
                label: const Text('未读'),
                onSelected: (_) => onReadStatusChanged(0),
              ),
              ChoiceChip(
                selected: readStatus == 1,
                label: const Text('已读'),
                onSelected: (_) => onReadStatusChanged(1),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text('类型', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              ChoiceChip(
                selected: type.isEmpty,
                label: const Text('全部'),
                onSelected: (_) => onTypeChanged(''),
              ),
              for (final item in StatusLabels.notificationType.entries)
                ChoiceChip(
                  selected: type == item.key,
                  label: Text(item.value),
                  onSelected: (_) => onTypeChanged(item.key),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    final id = item.id;

    return WebCalCard(
      onTap: id == null ? null : () => context.push('/notifications/$id'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NotificationIcon(readStatus: item.readStatus),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  _textOrDefault(item.title, '通知'),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              StatusPill(label: _readLabel(item.readStatus)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _textOrDefault(item.content, '暂无正文'),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.muted,
              height: 1.45,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              StatusPill(
                label: StatusLabels.of(
                  StatusLabels.notificationType,
                  item.type,
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  DateTimeFormatters.compact(item.createdAt),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({required this.readStatus});

  final int? readStatus;

  @override
  Widget build(BuildContext context) {
    final unread = readStatus == 0;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: unread
            ? AppColors.electricGreen.withValues(alpha: 0.34)
            : AppColors.softBackground,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Icon(
          unread ? LucideIcons.mail : LucideIcons.mailOpen,
          color: AppColors.deepForest,
          size: 20,
        ),
      ),
    );
  }
}

String _activeFilterLabel(int? readStatus, String type) {
  final parts = <String>[];
  if (readStatus != null) {
    parts.add(_readLabel(readStatus));
  }
  if (type.isNotEmpty) {
    parts.add(StatusLabels.of(StatusLabels.notificationType, type));
  }
  return parts.isEmpty ? '全部通知' : parts.join(' · ');
}

String _emptySubtitle(int? readStatus, String type) {
  final label = _activeFilterLabel(readStatus, type);
  if (label == '全部通知') {
    return '新的订单、充值、提现和结算进展会在这里显示。';
  }
  return '当前筛选没有通知，可以切回全部或稍后刷新。';
}

String _textOrDefault(String? value, String fallback) {
  final text = value?.trim();
  return text == null || text.isEmpty ? fallback : text;
}

String _readLabel(int? status) {
  if (status == 0) {
    return '未读';
  }
  if (status == 1) {
    return '已读';
  }
  return '未知';
}
