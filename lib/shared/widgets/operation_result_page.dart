import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../app/theme.dart';
import 'screen_scaffold.dart';
import 'webcal_card.dart';

const _maxResultTextLength = 120;

class OperationResultPage extends StatelessWidget {
  const OperationResultPage({
    super.key,
    required this.title,
    required this.message,
    required this.primaryLabel,
    required this.primaryPath,
    required this.secondaryLabel,
    required this.secondaryPath,
    this.success = true,
  });

  final String title;
  final String message;
  final String primaryLabel;
  final String primaryPath;
  final String secondaryLabel;
  final String secondaryPath;
  final bool success;

  @override
  Widget build(BuildContext context) {
    final effectiveTitle = _cleanText(
      title,
      fallback: success ? '操作已提交' : '操作未完成',
    );
    final effectiveMessage = _cleanText(
      message,
      fallback: success ? '请以详情页中的服务端状态为准。' : '请返回后重试，或刷新详情查看最新状态。',
    );
    final effectivePrimaryLabel = _cleanText(primaryLabel, fallback: '查看详情');
    final effectiveSecondaryLabel = _cleanText(
      secondaryLabel,
      fallback: '返回首页',
    );

    return ScreenScaffold(
      title: '交易结果',
      children: [
        const SizedBox(height: AppSpacing.xl),
        _ResultMark(color: _resultColor, icon: _resultIcon),
        const SizedBox(height: AppSpacing.lg),
        Text(
          effectiveTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            effectiveMessage,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        WebCalCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SummaryLine(
                label: '处理状态',
                value: success ? '已提交服务端' : '需要重新处理',
                icon: success ? LucideIcons.badgeCheck : LucideIcons.xCircle,
                color: _resultColor,
              ),
              const Divider(height: AppSpacing.lg, color: AppColors.outline),
              _SummaryLine(
                label: '下一步',
                value: effectivePrimaryLabel,
                icon: LucideIcons.clock,
                color: AppColors.deepForest,
              ),
              const Divider(height: AppSpacing.lg, color: AppColors.outline),
              _SummaryLine(
                label: '数据依据',
                value: '服务端最新状态',
                icon: LucideIcons.serverCog,
                color: AppColors.deepForest,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        ElevatedButton.icon(
          onPressed: () => context.go(primaryPath),
          icon: const Icon(LucideIcons.arrowRight),
          label: Text(
            effectivePrimaryLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton.icon(
          onPressed: () => context.go(secondaryPath),
          icon: const Icon(LucideIcons.home),
          label: Text(
            effectiveSecondaryLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color get _resultColor => success ? AppColors.deepForest : AppColors.danger;

  IconData get _resultIcon =>
      success ? LucideIcons.checkCircle2 : LucideIcons.xCircle;
}

String _cleanText(String value, {required String fallback}) {
  final text = value.trim().replaceAll(RegExp(r'\s+'), ' ');
  if (text.isEmpty) {
    return fallback;
  }
  if (text.length <= _maxResultTextLength) {
    return text;
  }
  return '${text.substring(0, _maxResultTextLength)}...';
}

class _ResultMark extends StatelessWidget {
  const _ResultMark({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.22),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Icon(icon, color: color, size: 54),
        ),
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Icon(icon, size: 18, color: color),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Flexible(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.ink,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
