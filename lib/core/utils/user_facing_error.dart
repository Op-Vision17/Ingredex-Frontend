import 'package:dio/dio.dart';

/// Maps exceptions to short, user-friendly messages for UI.
String userFacingError(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet and try again.';
      case DioExceptionType.connectionError:
        return 'Unable to reach the server. Please check your connection.';
      case DioExceptionType.badResponse:
        final code = error.response?.statusCode;
        if (code == 401) return 'Session expired. Please sign in again.';
        if (code == 403) return 'You do not have access to this feature.';
        if (code == 404) return 'The requested item was not found.';
        if (code == 422) return 'Could not read or process the input. Please try again.';
        if (code == 503 || code == 504) {
          return 'Analysis service is busy. Please try again in a few moments.';
        }
        if (code != null && code >= 500) {
          return 'Our servers are experiencing high load. Please try again shortly.';
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
