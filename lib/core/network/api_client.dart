import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/env.dart';
import '../storage/token_store.dart';
import 'api_exception.dart';

final authInvalidationProvider = StateProvider<int>((ref) => 0);

final dioProvider = Provider<Dio>((ref) {
  final tokenStore = ref.watch(tokenStoreProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 15),
      contentType: Headers.jsonContentType,
      headers: const {'Accept': 'application/json', 'Accept-Language': 'zh-CN'},
    ),
  );

  dio.interceptors.add(
    QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await tokenStore.readAccessToken();
        if (token != null &&
            token.isNotEmpty &&
            !_isPublicRequestPath(options.path)) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await tokenStore.clear();
          ref.read(authInvalidationProvider.notifier).state++;
        }
        handler.next(error);
      },
    ),
  );

  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final tokenStore = ref.watch(tokenStoreProvider);
  return ApiClient(ref.watch(dioProvider), () async {
    await tokenStore.clear();
    ref.read(authInvalidationProvider.notifier).state++;
  });
});

class ApiClient {
  const ApiClient(this._dio, this._handleAuthInvalid);

  final Dio _dio;
  final Future<void> Function() _handleAuthInvalid;

  Future<Object?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _guard(
      () => _dio.get<Object?>(path, queryParameters: queryParameters),
    );
    return _unwrap(response);
  }

  Future<Object?> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _guard(
      () => _dio.post<Object?>(
        path,
        data: data,
        queryParameters: queryParameters,
      ),
    );
    return _unwrap(response);
  }

  Future<Object?> put(String path, {Object? data}) async {
    final response = await _guard(() => _dio.put<Object?>(path, data: data));
    return _unwrap(response);
  }

  Future<Response<Object?>> _guard(
    Future<Response<Object?>> Function() request,
  ) async {
    try {
      return await request();
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;
      final body = _asStringKeyMap(error.response?.data);
      if (body != null) {
        final businessCode = int.tryParse(body['code']?.toString() ?? '');
        if (businessCode != null && _isAuthInvalidBusinessCode(businessCode)) {
          if (statusCode != 401) {
            await _handleAuthInvalid();
          }
          throw ApiException(
            body['message']?.toString() ?? '登录已失效，请重新登录',
            statusCode: 401,
            businessCode: businessCode,
          );
        }
        throw ApiException(
          body['message']?.toString() ?? '请求失败',
          statusCode: statusCode,
          businessCode: businessCode,
        );
      }
      if (statusCode == 401) {
        throw const ApiException('登录已失效，请重新登录', statusCode: 401);
      }
      if (statusCode == 403) {
        throw const ApiException('当前账号无权限访问', statusCode: 403);
      }
      throw ApiException(_friendlyDioMessage(error), statusCode: statusCode);
    }
  }

  Future<Object?> _unwrap(Response<Object?> response) async {
    final body = response.data;
    final bodyMap = _asStringKeyMap(body);
    if (bodyMap == null) {
      return body;
    }

    final code = int.tryParse(bodyMap['code']?.toString() ?? '');
    if (code != null && code != 0) {
      if (_isAuthInvalidBusinessCode(code)) {
        await _handleAuthInvalid();
        throw ApiException(
          bodyMap['message']?.toString() ?? '登录已失效，请重新登录',
          statusCode: 401,
          businessCode: code,
        );
      }
      throw ApiException(
        bodyMap['message']?.toString() ?? '业务处理失败',
        statusCode: response.statusCode,
        businessCode: code,
      );
    }

    if (bodyMap.containsKey('data')) {
      return bodyMap['data'];
    }
    return bodyMap;
  }

  String _friendlyDioMessage(DioException error) {
    final statusCode = error.response?.statusCode;
    if (statusCode != null && statusCode >= 500) {
      return '服务器暂时不可用，请稍后重试';
    }
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => '网络连接超时，请稍后重试',
      DioExceptionType.connectionError => '网络连接异常，请检查网络后重试',
      DioExceptionType.badCertificate => '连接安全校验失败，请稍后重试',
      DioExceptionType.cancel => '请求已取消',
      _ => '网络异常，请稍后重试',
    };
  }

  Map<String, dynamic>? _asStringKeyMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return value.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }
}

bool _isAuthInvalidBusinessCode(int code) {
  return code == 20012;
}

bool _isPublicRequestPath(String path) {
  final uri = Uri.tryParse(path);
  final cleanPath = uri?.path ?? path;
  if (_publicAuthPaths.contains(cleanPath)) {
    return true;
  }
  if (cleanPath == '/api/products' || cleanPath.startsWith('/api/products/')) {
    return true;
  }
  if (cleanPath == '/api/rental/estimate') {
    return true;
  }
  if (cleanPath == '/api/system/enums' || cleanPath == '/api/system/health') {
    return true;
  }
  if (cleanPath == '/api/docs/categories' ||
      cleanPath == '/api/docs/search' ||
      cleanPath == '/api/docs/articles' ||
      cleanPath.startsWith('/api/docs/articles/')) {
    return true;
  }
  if (cleanPath == '/api/blog/categories' ||
      cleanPath == '/api/blog/tags' ||
      cleanPath == '/api/blog/posts' ||
      cleanPath.startsWith('/api/blog/posts/')) {
    return true;
  }
  return cleanPath == '/api/ai-models' ||
      cleanPath == '/api/gpu-models' ||
      cleanPath == '/api/regions' ||
      cleanPath == '/api/rental-cycle-rules' ||
      cleanPath == '/api/system/business-configs';
}

const _publicAuthPaths = <String>{
  '/api/auth/signup/email-code/send',
  '/api/auth/signup/email-code/verify',
  '/api/auth/signup',
  '/api/auth/register',
  '/api/auth/login',
  '/api/auth/login/password',
  '/api/auth/password/reset',
  '/api/auth/reset-password/email-code/send',
  '/api/auth/reset-password/email-code/verify',
  '/api/auth/reset-password',
  '/api/security/password-public-key',
};
