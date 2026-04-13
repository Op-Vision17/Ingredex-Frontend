import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart' show providerContainer;
import '../../features/auth/providers/auth_provider.dart';
import '../constants/app_constants.dart';
import '../storage/secure_storage.dart';
import '../utils/snackbar_service.dart';
import 'api_endpoints.dart';
import 'network_error_handler.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

class DioClient {
  DioClient() : _dio = Dio(_baseOptions()) {
    _dio.interceptors.add(AuthInterceptor(_dio));
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  final Dio _dio;

  Dio get dio => _dio;

  static BaseOptions _baseOptions() {
    return BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(
        milliseconds: AppConstants.connectTimeoutMs,
      ),
      receiveTimeout: const Duration(
        milliseconds: AppConstants.receiveTimeoutMs,
      ),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? params}) {
    return _dio.get(path, queryParameters: params);
  }

  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Options? options,
  }) {
    return _dio.post(path, data: data, options: options);
  }

  Future<Response<dynamic>> put(String path, {dynamic data, Options? options}) {
    return _dio.put(path, data: data, options: options);
  }

  Future<Response<dynamic>> postMultipart(String path, FormData formData) {
    return _dio.post(
      path,
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
  }

  Future<Response<dynamic>> delete(String path) {
    return _dio.delete(path);
  }
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._dio);

  final Dio _dio;
  bool _isRefreshing = false;
  Future<void>? _refreshFuture;
  static DateTime? _lastNetworkSnackbar;

  void _showNetworkError(String message) {
    final now = DateTime.now();
    if (_lastNetworkSnackbar != null &&
        now.difference(_lastNetworkSnackbar!) < const Duration(seconds: 3)) {
      return;
    }
    _lastNetworkSnackbar = now;
    SnackBarService.show(message);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorageService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final request = err.requestOptions;
    final isUnauthorized = statusCode == 401;
    final isRefreshCall = request.path == ApiEndpoints.refresh;
    final isVerifyOtpCall = request.path == ApiEndpoints.verifyOtp;
    final alreadyRetried = request.extra['retried'] == true;

    if (!isUnauthorized || isRefreshCall || isVerifyOtpCall || alreadyRetried) {
      if (_shouldRetry(err, request)) {
        try {
          final response = await _retryOnce(request);
          handler.resolve(response);
          return;
        } catch (_) {
          _showNetworkError(NetworkErrorHandler.messageFromDio(err));
          handler.next(_withFriendlyMessage(err));
          return;
        }
      }
      _showNetworkError(NetworkErrorHandler.messageFromDio(err));
      handler.next(_withFriendlyMessage(err));
      return;
    }

    try {
      await _refreshAccessToken();

      final newAccessToken = await SecureStorageService.getAccessToken();
      if (newAccessToken == null || newAccessToken.isEmpty) {
        throw DioException(
          requestOptions: request,
          error: 'Missing access token after refresh',
        );
      }

      final retryOptions = Options(
        method: request.method,
        headers: {
          ...request.headers,
          'Authorization': 'Bearer $newAccessToken',
        },
        extra: {...request.extra, 'retried': true},
      );

      final response = await _dio.request<dynamic>(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: retryOptions,
      );
      handler.resolve(response);
    } catch (_) {
      await SecureStorageService.clearTokens();
      await providerContainer
          .read(authNotifierProvider.notifier)
          .forceUnauthenticated();
      _showNetworkError('Session expired. Please login again.');
      handler.next(_withFriendlyMessage(err));
    }
  }

  bool _shouldRetry(DioException err, RequestOptions request) {
    // Never retry if already retried
    if (request.extra['network_retried'] == true) return false;

    // Only retry safe idempotent methods — never POST, PUT, DELETE, PATCH
    final method = request.method.toUpperCase();
    const safeMethods = {'GET', 'HEAD', 'OPTIONS'};
    if (!safeMethods.contains(method)) return false;

    // Retrying POST /analyze runs CrewAI twice and worsens timeouts.
    if (request.path == ApiEndpoints.analyze) return false;

    // Only retry on network-level failures, not 4xx/5xx responses
    return NetworkErrorHandler.isRetryable(err);
  }

  Future<Response<dynamic>> _retryOnce(RequestOptions request) {
    final options = Options(
      method: request.method,
      headers: request.headers,
      extra: {...request.extra, 'network_retried': true},
    );
    return _dio.request<dynamic>(
      request.path,
      data: request.data,
      queryParameters: request.queryParameters,
      options: options,
    );
  }

  DioException _withFriendlyMessage(DioException err) {
    return DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: NetworkErrorHandler.messageFromDio(err),
      stackTrace: err.stackTrace,
      message: NetworkErrorHandler.messageFromDio(err),
    );
  }

  Future<void> _refreshAccessToken() async {
    if (_isRefreshing) {
      await _refreshFuture;
      return;
    }

    _isRefreshing = true;
    _refreshFuture = _doRefresh();
    try {
      await _refreshFuture;
    } finally {
      _isRefreshing = false;
      _refreshFuture = null;
    }
  }

  Future<void> _doRefresh() async {
    final refreshToken = await SecureStorageService.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('Missing refresh token');
    }

    final response = await _dio.post<dynamic>(
      ApiEndpoints.refresh,
      data: {'refresh_token': refreshToken},
      options: Options(
        headers: {'Authorization': null},
        extra: {'retried': true},
      ),
    );

    final data = response.data as Map<String, dynamic>;
    final accessToken = data['access_token'] as String?;
    final newRefreshToken = data['refresh_token'] as String?;

    if (accessToken == null || newRefreshToken == null) {
      throw Exception('Invalid refresh response');
    }

    await SecureStorageService.saveTokens(
      accessToken: accessToken,
      refreshToken: newRefreshToken,
    );
  }
}

final dioProvider = Provider<Dio>((ref) {
  return ref.read(dioClientProvider).dio;
});
