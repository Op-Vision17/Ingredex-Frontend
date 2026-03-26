class ApiEndpoints {
  const ApiEndpoints._();

  static const sendOtp = '/auth/send-otp';
  static const verifyOtp = '/auth/verify-otp';
  static const refresh = '/auth/refresh';
  static const logout = '/auth/logout';
  static const me = '/auth/me';

  static const scanBarcode = '/scan/barcode';
  static const scanOcr = '/scan/ocr';
  static const analyze = '/analyze';

  static const history = '/history';
  static const historyStats = '/history/stats';

  static String historyDetail(String id) => '/history/$id';
  static String deleteHistory(String id) => '/history/$id';
}
