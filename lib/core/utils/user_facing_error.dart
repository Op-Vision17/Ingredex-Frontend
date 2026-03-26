import 'package:dio/dio.dart';

/// Maps exceptions to short, non-sensitive messages for UI.
String userFacingError(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Check your network and try again.';
      case DioExceptionType.connectionError:
        return 'Could not reach the server. Check your internet and try again.';
      case DioExceptionType.badResponse:
        final code = error.response?.statusCode;
        if (code == 401) return 'Please sign in again.';
        if (code == 403) return 'You do not have access to this.';
        if (code == 404) return 'Not found.';
        if (code != null && code >= 500) {
          return 'Server error. Please try again later.';
        }
        return 'Something went wrong. Please try again.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      default:
        break;
    }
  }
  return 'Something went wrong. Please try again.';
}
