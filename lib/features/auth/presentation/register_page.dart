import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../app/theme.dart';
import '../../../core/utils/error_messages.dart';
import '../data/auth_controller.dart';
import '../data/auth_repository.dart';
import 'auth_shell.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key, this.redirectPath});

  final String? redirectPath;

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _inviteController = TextEditingController();
  bool _sendingCode = false;
  bool _passwordVisible = false;
  int _codeCooldown = 0;
  Timer? _codeTimer;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _inviteController.dispose();
    _codeTimer?.cancel();
    super.dispose();
  }

  void _startCodeCooldown() {
    _codeTimer?.cancel();
    setState(() => _codeCooldown = 60);
    _codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_codeCooldown <= 1) {
        timer.cancel();
        setState(() => _codeCooldown = 0);
        return;
      }
      setState(() => _codeCooldown--);
    });
  }

  Future<void> _sendCode() async {
    if (_sendingCode || _codeCooldown > 0) {
      return;
    }
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      toastification.show(
        context: context,
        type: ToastificationType.warning,
        title: const Text('请先输入有效邮箱'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      return;
    }
    setState(() => _sendingCode = true);
    try {
      await ref.read(authRepositoryProvider).sendSignupCode(email);
      if (!mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('验证码已发送'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      _startCodeCooldown();
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
        setState(() => _sendingCode = false);
      }
    }
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
        .signup(
          email: _emailController.text.trim(),
          code: _codeController.text.trim(),
          password: _passwordController.text,
          userName: _nameController.text.trim(),
          inviteCode: _inviteController.text.trim(),
        );
    final state = ref.read(authControllerProvider);
    if (!mounted) {
      return;
    }
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
    final loading = ref.watch(authControllerProvider).isLoading;
    final canSendCode = !_sendingCode && _codeCooldown == 0 && !loading;

    return AuthShell(
      title: '创建账号',
      subtitle: '注册后可直接进入首页，钱包和团队关系由后端初始化。',
      footer: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '已有账号？',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
          TextButton(
            onPressed: loading ? null : () => context.go(_loginPath),
            child: const Text('去登录'),
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
                    return value.contains('@') ? null : '邮箱格式不正确';
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: const InputDecoration(
                    labelText: '邮箱验证码',
                    prefixIcon: Icon(LucideIcons.keyRound),
                  ),
                  validator: (value) {
                    final code = value?.trim() ?? '';
                    if (code.isEmpty) {
                      return '请输入验证码';
                    }
                    if (!RegExp(r'^\d{4,10}$').hasMatch(code)) {
                      return '验证码为 4-10 位数字';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton(
                  onPressed: canSendCode ? _sendCode : null,
                  child: Text(
                    _sendingCode
                        ? '发送中...'
                        : _codeCooldown > 0
                        ? '${_codeCooldown}s 后重发'
                        : '发送验证码',
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.name],
                  decoration: const InputDecoration(
                    labelText: '昵称',
                    prefixIcon: Icon(LucideIcons.user),
                  ),
                  maxLength: 64,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '请输入昵称';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.newPassword],
                  autocorrect: false,
                  enableSuggestions: false,
                  inputFormatters: [LengthLimitingTextInputFormatter(72)],
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
                    final password = value ?? '';
                    if (password.length < 8 || password.length > 72) {
                      return '密码需为 8-72 位';
                    }
                    if (password.contains(RegExp(r'\s'))) {
                      return '密码不能包含空白字符';
                    }
                    if (!password.contains(RegExp('[A-Za-z]')) ||
                        !password.contains(RegExp(r'\d'))) {
                      return '密码需包含字母和数字';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _inviteController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                  ],
                  onFieldSubmitted: (_) {
                    if (!loading) {
                      _submit();
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: '邀请码（可选）',
                    prefixIcon: Icon(LucideIcons.network),
                  ),
                  validator: (value) {
                    final inviteCode = value?.trim() ?? '';
                    if (inviteCode.isEmpty) {
                      return null;
                    }
                    return RegExp(r'^\d{8}$').hasMatch(inviteCode)
                        ? null
                        : '邀请码为 8 位数字';
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton.icon(
                  onPressed: loading ? null : _submit,
                  icon: const Icon(LucideIcons.arrowRight),
                  label: Text(loading ? '提交中...' : '注册并进入'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String get _loginPath {
    final target = widget.redirectPath;
    if (target == null || target.isEmpty) {
      return '/login';
    }
    return Uri(path: '/login', queryParameters: {'from': target}).toString();
  }
}
