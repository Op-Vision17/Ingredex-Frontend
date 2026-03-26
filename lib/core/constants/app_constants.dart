class AppConstants {
  const AppConstants._();

  static const baseUrl = 'http://192.168.1.8:8000';

  static const accessTokenKey = 'access_token';
  static const refreshTokenKey = 'refresh_token';
  static const userEmailKey = 'user_email';

  static const connectTimeoutMs = 15000;
  static const receiveTimeoutMs = 30000;
  static const analyzeReceiveTimeoutMs = 120000;
  static const sendTimeoutMs = 15000;
  static const otpCountdownSeconds = 60;
}
