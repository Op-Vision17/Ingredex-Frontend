import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/secure_storage.dart';
import 'models/auth_models.dart' as models;

class AuthRepository {
  AuthRepository(this._client);
  final DioClient _client;

  Future<void> sendOtp(String email) async {
    await _client.post(
      ApiEndpoints.sendOtp,
      data: models.SendOtpRequest(email: email).toJson(),
    );
    await SecureStorageService.saveUserEmail(email);
  }

  Future<models.AuthTokens> verifyOtp(String email, String otp) async {
    final response = await _client.post(
      ApiEndpoints.verifyOtp,
      data: models.VerifyOtpRequest(email: email, otp: otp).toJson(),
    );
    final tokens = models.AuthTokens.fromJson(
      response.data as Map<String, dynamic>,
    );
    await SecureStorageService.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    await SecureStorageService.saveUserEmail(email);
    return tokens;
  }

  Future<void> logout() async {
    try {
      final refreshToken = await SecureStorageService.getRefreshToken();
      await _client.post(
        ApiEndpoints.logout,
        data: {'refresh_token': refreshToken},
      );
    } catch (_) {
      // Ignore API errors — always clear local tokens
    } finally {
      await SecureStorageService.clearTokens();
    }
  }

  Future<models.UserProfile> getCurrentUser() async {
    final response = await _client.get(ApiEndpoints.me);
    return models.UserProfile.fromJson(response.data as Map<String, dynamic>);
  }

  Future<bool> isLoggedIn() async {
    final token = await SecureStorageService.getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
