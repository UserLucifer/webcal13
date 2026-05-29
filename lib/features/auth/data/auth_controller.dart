import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../shared/models/app_models.dart';
import 'auth_repository.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<AuthSession?>>((ref) {
      final controller = AuthController(ref.watch(authRepositoryProvider));
      ref.listen<int>(authInvalidationProvider, (previous, next) {
        if (previous != null && previous != next) {
          controller.invalidateSession();
        }
      });
      return controller..restore();
    });

class AuthController extends StateNotifier<AsyncValue<AuthSession?>> {
  AuthController(this._repository) : super(const AsyncLoading());

  final AuthRepository _repository;

  Future<void> restore() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_repository.restoreSession);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repository.login(email: email, password: password),
    );
  }

  Future<void> signup({
    required String email,
    required String code,
    required String password,
    String? userName,
    String? inviteCode,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repository.signup(
        email: email,
        code: code,
        password: password,
        userName: userName,
        inviteCode: inviteCode,
      ),
    );
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await _repository.logout();
    } finally {
      state = const AsyncData(null);
    }
  }

  void invalidateSession() {
    state = const AsyncData(null);
  }
}
