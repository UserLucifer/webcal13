import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/pagination.dart';
import '../../../core/storage/token_store.dart';
import '../../../shared/models/app_models.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(apiClientProvider),
    ref.watch(tokenStoreProvider),
  );
});

final currentUserProvider = FutureProvider<UserProfile>((ref) {
  return ref.watch(authRepositoryProvider).me();
});

class AuthRepository {
  const AuthRepository(this._api, this._tokenStore);

  final ApiClient _api;
  final TokenStore _tokenStore;

  Future<AuthSession?> restoreSession() async {
    final token = await _tokenStore.readAccessToken();
    if (token == null || token.isEmpty) {
      return null;
    }
    try {
      final user = await me();
      return AuthSession(accessToken: token, tokenType: 'Bearer', user: user);
    } on ApiException catch (error) {
      if (error.statusCode == 401) {
        await _tokenStore.clear();
        return null;
      }
      return AuthSession(accessToken: token, tokenType: 'Bearer');
    } catch (_) {
      return AuthSession(accessToken: token, tokenType: 'Bearer');
    }
  }

  Future<void> sendSignupCode(String email) async {
    await _api.post('/api/auth/signup/email-code/send', data: {'email': email});
  }

  Future<void> verifySignupCode(String email, String code) async {
    await _api.post(
      '/api/auth/signup/email-code/verify',
      data: {'email': email, 'code': code},
    );
  }

  Future<void> sendResetPasswordCode(String email) async {
    await _api.post(
      '/api/auth/reset-password/email-code/send',
      data: {'email': email},
    );
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    await _api.post(
      '/api/auth/reset-password',
      data: {'email': email, 'code': code, 'newPassword': newPassword},
    );
  }

  Future<AuthSession> signup({
    required String email,
    required String code,
    required String password,
    String? userName,
    String? inviteCode,
  }) async {
    final data = await _api.post(
      '/api/auth/signup',
      data: {
        'email': email,
        'code': code,
        'password': password,
        if (userName != null && userName.isNotEmpty) 'userName': userName,
        if (inviteCode != null && inviteCode.isNotEmpty)
          'inviteCode': inviteCode,
      },
    );
    final session = parseObject(data, AuthSession.fromJson);
    await _tokenStore.saveAccessToken(session.accessToken);
    return session;
  }

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final data = await _api.post(
      '/api/auth/login/password',
      data: {'email': email, 'password': password},
    );
    final session = parseObject(data, AuthSession.fromJson);
    await _tokenStore.saveAccessToken(session.accessToken);
    return session;
  }

  Future<UserProfile> me() async {
    final data = await _api.get('/api/user/me');
    return parseObject(data, UserProfile.fromJson);
  }

  Future<UserProfile> updateAvatar(String avatarKey) async {
    final data = await _api.put(
      '/api/user/avatar',
      data: {'avatarKey': avatarKey},
    );
    return parseObject(data, UserProfile.fromJson);
  }

  Future<void> logout() async {
    try {
      await _api.post('/api/auth/logout');
    } catch (_) {
      // Local logout should still complete if the server session is expired.
    }
    await _tokenStore.clear();
  }
}
