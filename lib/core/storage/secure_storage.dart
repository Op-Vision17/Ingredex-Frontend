import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';

class SecureStorageService {
  SecureStorageService._();

  static const _storage = FlutterSecureStorage();

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: AppConstants.accessTokenKey, value: accessToken);
    await _storage.write(key: AppConstants.refreshTokenKey, value: refreshToken);
  }

  static Future<String?> getAccessToken() {
    return _storage.read(key: AppConstants.accessTokenKey);
  }

  static Future<String?> getRefreshToken() {
    return _storage.read(key: AppConstants.refreshTokenKey);
  }

  static Future<void> clearTokens() async {
    await _storage.delete(key: AppConstants.accessTokenKey);
    await _storage.delete(key: AppConstants.refreshTokenKey);
  }

  static Future<void> saveUserEmail(String email) {
    return _storage.write(key: AppConstants.userEmailKey, value: email);
  }

  static Future<String?> getUserEmail() {
    return _storage.read(key: AppConstants.userEmailKey);
  }
}
