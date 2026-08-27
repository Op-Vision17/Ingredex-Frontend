import 'package:dio/dio.dart';

class NetworkErrorHandler {
  const NetworkErrorHandler._();

  static String messageFromDio(DioException error) {
    final status = error.response?.statusCode;
    if (status == 401) return 'Session expired. Please sign in again.';
    if (status == 403) return 'You do not have permission for this action.';
    if (status == 404) return 'The requested information could not be found.';
    if (status == 422) return 'Could not read or process the provided input. Please try again.';
    if (status == 503 || status == 504) {
      return 'The analysis service is currently busy. Please try again in a few moments.';
    }
    if (status != null && status >= 500) {
      return 'Our servers are experiencing high traffic. Please try again in a moment.';
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet and try again.';
      case DioExceptionType.connectionError:
        return 'Unable to reach Ingredex. Please check your internet connection.';
      default:
        return 'Something went wrong. Please try again in a moment.';
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
