import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../data/auth_repository.dart';
import '../data/models/auth_models.dart';

part 'auth_provider.freezed.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(dioClientProvider));
});

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unknown() = _Unknown;
  const factory AuthState.otpSent(String email) = _OtpSent;
  const factory AuthState.authenticated(UserProfile user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<AuthState> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> forceUnauthenticated() async {
    state = const AsyncValue.data(AuthState.unauthenticated());
  }

  @override
  Future<AuthState> build() async {
    state = const AsyncValue.data(AuthState.unknown());
    try {
      final loggedIn = await _repo.isLoggedIn();
      if (!loggedIn) return const AuthState.unauthenticated();
      final user = await _repo.getCurrentUser();
      return AuthState.authenticated(user);
    } catch (_) {
      return const AuthState.unauthenticated();
    }
  }

  Future<void> sendOtp(String email) async {
    state = const AsyncValue.loading();
    try {
      await _repo.sendOtp(email);
      state = AsyncValue.data(AuthState.otpSent(email));
    } catch (e) {
      state = AsyncValue.data(AuthState.error(_messageFrom(e)));
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    state = const AsyncValue.loading();
    try {
      await _repo.verifyOtp(email, otp);
      final user = await _repo.getCurrentUser();
      state = AsyncValue.data(AuthState.authenticated(user));
    } catch (e) {
      state = AsyncValue.data(AuthState.error(_messageFrom(e)));
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await _repo.logout();
      state = const AsyncValue.data(AuthState.unauthenticated());
    } catch (e) {
      state = AsyncValue.data(AuthState.error(_messageFrom(e)));
    }
  }

  Future<void> checkAuthStatus() async {
    state = const AsyncValue.data(AuthState.unknown());
    try {
      final loggedIn = await _repo.isLoggedIn();
      if (!loggedIn) {
        state = const AsyncValue.data(AuthState.unauthenticated());
        return;
      }
      final user = await _repo.getCurrentUser();
      state = AsyncValue.data(AuthState.authenticated(user));
    } catch (_) {
      state = const AsyncValue.data(AuthState.unauthenticated());
    }
  }

  String _messageFrom(Object e) {
    if (e is DioException) {
      final status = e.response?.statusCode;
      if (status == 401) return 'Invalid or expired OTP.';
      if (status == 422) return 'Please enter a valid email.';
      if (status != null && status >= 500) {
        return 'Server error. Please try again.';
      }
      return e.message ?? 'Network error. Please try again.';
    }
    final text = e.toString();
    if (text.contains('YOUR_LOCAL_IP')) {
      return 'Base URL is not configured correctly in app_constants.dart';
    }
    return text.isNotEmpty ? text : 'Something went wrong. Please try again.';
  }
}
