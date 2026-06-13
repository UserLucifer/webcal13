import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

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
    final encryptedPassword = await _encryptPassword(newPassword);
    await _api.post(
      '/api/auth/reset-password',
      data: {
        'email': email,
        'code': code,
        'newPasswordCiphertext': encryptedPassword.ciphertext,
        'keyId': encryptedPassword.keyId,
      },
    );
  }

  Future<AuthSession> signup({
    required String email,
    required String code,
    required String password,
    String? userName,
    String? inviteCode,
  }) async {
    final encryptedPassword = await _encryptPassword(password);
    final data = await _api.post(
      '/api/auth/signup',
      data: {
        'email': email,
        'code': code,
        'userName': userName?.trim() ?? '',
        'passwordCiphertext': encryptedPassword.ciphertext,
        'keyId': encryptedPassword.keyId,
        'inviteCode': inviteCode?.trim() ?? '',
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
    final encryptedPassword = await _encryptPassword(password);
    final data = await _api.post(
      '/api/auth/login/password',
      data: {
        'email': email,
        'passwordCiphertext': encryptedPassword.ciphertext,
        'keyId': encryptedPassword.keyId,
      },
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

  Future<_EncryptedPassword> _encryptPassword(String password) async {
    try {
      final data = await _api.get('/api/security/password-public-key');
      final keyResponse = parseObject(data, _PasswordPublicKey.fromJson);
      final normalizedAlgorithm = keyResponse.algorithm.toUpperCase();
      if (!normalizedAlgorithm.contains('RSA-OAEP') ||
          !normalizedAlgorithm.contains('256')) {
        throw const FormatException(
          'Unsupported password encryption algorithm',
        );
      }
      final publicKey = RSAKeyParser.parsePublicKeyFromPem(
        keyResponse.publicKey,
      );
      final ciphertext = RSAOAEP(
        hash: SHA256Digest(),
      ).encryptString(password, publicKey);
      return _EncryptedPassword(
        keyId: keyResponse.keyId,
        ciphertext: ciphertext,
      );
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('服务端密码加密配置暂不可用，请稍后重试');
    }
  }
}

class _PasswordPublicKey {
  const _PasswordPublicKey({
    required this.keyId,
    required this.publicKey,
    required this.algorithm,
  });

  factory _PasswordPublicKey.fromJson(Map<String, dynamic> json) {
    final keyId = json['keyId']?.toString() ?? '';
    final publicKey = json['publicKey']?.toString() ?? '';
    final algorithm = json['algorithm']?.toString() ?? '';
    if (keyId.isEmpty || publicKey.isEmpty || algorithm.isEmpty) {
      throw const FormatException('Invalid password public key response');
    }
    return _PasswordPublicKey(
      keyId: keyId,
      publicKey: publicKey,
      algorithm: algorithm,
    );
  }

  final String keyId;
  final String publicKey;
  final String algorithm;
}

class _EncryptedPassword {
  const _EncryptedPassword({required this.keyId, required this.ciphertext});

  final String keyId;
  final String ciphertext;
}
