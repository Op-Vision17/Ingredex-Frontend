import 'package:dio/dio.dart';

class NetworkErrorHandler {
  const NetworkErrorHandler._();

  static String messageFromDio(DioException error) {
    final status = error.response?.statusCode;
    if (status == 401) return 'Session expired. Please login again.';
    if (status == 403) return 'You are not allowed to perform this action.';
    if (status == 404) return 'Requested data was not found.';
    if (status == 422) return 'Please check your input and try again.';
    if (status != null && status >= 500) {
      return 'Server is unavailable. Please try again later.';
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return 'Network issue. Please check your internet and retry.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  static bool isRetryable(DioException error) {
    // Only retry on client-side connectivity failures.
    // Never retry on server responses (even 5xx), as requests may
    // already be processed on backend side.
    if (error.response != null) {
      return false;
    }
    return switch (error.type) {
      DioExceptionType.connectionTimeout => true,
      DioExceptionType.sendTimeout => true,
      DioExceptionType.receiveTimeout => true,
      DioExceptionType.connectionError => true,
      _ => false,
    };
  }
}
