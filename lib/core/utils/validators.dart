class Validators {
  const Validators._();

  static String? email(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(v)) return 'Enter a valid email';
    return null;
  }

  static String? otp(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'OTP is required';
    if (!RegExp(r'^\d{4,6}$').hasMatch(v)) return 'OTP must be 4-6 digits';
    return null;
  }

  static String? requiredText(String? value, {String field = 'Field'}) {
    if ((value ?? '').trim().isEmpty) return '$field is required';
    return null;
  }
}
