import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../app/theme.dart';
import '../../../core/utils/error_messages.dart';
import '../data/auth_repository.dart';
import 'auth_shell.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key, this.redirectPath});

  final String? redirectPath;

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _sending = false;
  bool _submitting = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  int _codeCooldown = 0;
  Timer? _codeTimer;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
    if (_sending || _codeCooldown > 0) {
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
    setState(() => _sending = true);
    try {
      await ref.read(authRepositoryProvider).sendResetPasswordCode(email);
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
        setState(() => _sending = false);
      }
    }
  }

  Future<void> _submit() async {
    if (_submitting) {
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _submitting = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .resetPassword(
            email: _emailController.text.trim(),
            code: _codeController.text.trim(),
            newPassword: _passwordController.text,
          );
      if (!mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('密码已重置'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      context.go(_loginPath);
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
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final canSendCode = !_sending && _codeCooldown == 0 && !_submitting;

    return AuthShell(
      title: '重置密码',
      subtitle: '通过邮箱验证码确认身份后更新登录密码。',
      footer: TextButton.icon(
        onPressed: _submitting ? null : () => context.go(_loginPath),
        icon: const Icon(LucideIcons.arrowLeft),
        label: const Text('返回登录'),
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
                    _sending
                        ? '发送中...'
                        : _codeCooldown > 0
                        ? '${_codeCooldown}s 后重发'
                        : '发送验证码',
                  ),
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
                    labelText: '新密码',
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
                  validator: _validatePassword,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_confirmPasswordVisible,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.newPassword],
                  autocorrect: false,
                  enableSuggestions: false,
                  inputFormatters: [LengthLimitingTextInputFormatter(72)],
                  onFieldSubmitted: (_) {
                    if (!_submitting) {
                      _submit();
                    }
                  },
                  decoration: InputDecoration(
                    labelText: '确认新密码',
                    prefixIcon: const Icon(LucideIcons.lock),
                    suffixIcon: IconButton(
                      onPressed: () => setState(
                        () =>
                            _confirmPasswordVisible = !_confirmPasswordVisible,
                      ),
                      icon: Icon(
                        _confirmPasswordVisible
                            ? LucideIcons.eyeOff
                            : LucideIcons.eye,
                      ),
                      tooltip: _confirmPasswordVisible ? '隐藏密码' : '显示密码',
                    ),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return '两次输入的密码不一致';
                    }
                    return _validatePassword(value);
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton.icon(
                  onPressed: _submitting ? null : _submit,
                  icon: const Icon(LucideIcons.checkCircle2),
                  label: Text(_submitting ? '提交中...' : '确认重置密码'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String? _validatePassword(String? value) {
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
  }

  String get _loginPath {
    final target = widget.redirectPath;
    if (target == null || target.isEmpty) {
      return '/login';
    }
    return Uri(path: '/login', queryParameters: {'from': target}).toString();
  }
}
