import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../app/theme.dart';
import '../../../core/utils/error_messages.dart';
import '../data/auth_controller.dart';
import 'auth_shell.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key, this.redirectPath});

  final String? redirectPath;

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (ref.read(authControllerProvider).isLoading) {
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await ref
        .read(authControllerProvider.notifier)
        .login(_emailController.text.trim(), _passwordController.text);
    if (!mounted) {
      return;
    }
    final state = ref.read(authControllerProvider);
    state.whenOrNull(
      data: (session) {
        if (session != null) {
          context.go(widget.redirectPath ?? '/home');
        }
      },
      error: (error, _) {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          title: Text(friendlyErrorMessage(error)),
          autoCloseDuration: const Duration(seconds: 3),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final loading = authState.isLoading;

    return AuthShell(
      title: '登录账户',
      subtitle: '管理算力租赁、钱包余额和收益记录。',
      footer: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '还没有账号？',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
          TextButton(
            onPressed: loading ? null : () => context.go(_registerPath),
            child: const Text('创建账号'),
          ),
        ],
      ),
      children: [
        AutofillGroup(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                  autocorrect: false,
                  enableSuggestions: false,
                  inputFormatters: [LengthLimitingTextInputFormatter(254)],
                  decoration: const InputDecoration(
                    labelText: '邮箱',
                    prefixIcon: Icon(LucideIcons.mail),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '请输入邮箱';
                    }
                    if (!value.contains('@')) {
                      return '邮箱格式不正确';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  autocorrect: false,
                  enableSuggestions: false,
                  inputFormatters: [LengthLimitingTextInputFormatter(72)],
                  onFieldSubmitted: (_) {
                    if (!loading) {
                      _submit();
                    }
                  },
                  decoration: InputDecoration(
                    labelText: '密码',
                    prefixIcon: const Icon(LucideIcons.lock),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _passwordVisible = !_passwordVisible),
                      icon: Icon(
                        _passwordVisible ? LucideIcons.eyeOff : LucideIcons.eye,
                      ),
                      tooltip: _passwordVisible ? '隐藏密码' : '显示密码',
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入密码';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: loading
                        ? null
                        : () => context.go(_resetPasswordPath),
                    child: const Text('忘记密码？'),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ElevatedButton.icon(
                  onPressed: loading ? null : _submit,
                  icon: const Icon(LucideIcons.arrowRight),
                  label: Text(loading ? '登录中...' : '登录'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String get _registerPath => _authPath('/register');

  String get _resetPasswordPath => _authPath('/reset-password');

  String _authPath(String path) {
    final target = widget.redirectPath;
    if (target == null || target.isEmpty) {
      return path;
    }
    return Uri(path: path, queryParameters: {'from': target}).toString();
  }
}
