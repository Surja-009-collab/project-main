import 'package:cloud_functions/cloud_functions.dart';

class ForgotPasswordService {
  ForgotPasswordService._();
  static final ForgotPasswordService instance = ForgotPasswordService._();

  final _functions = FirebaseFunctions.instance;

  Future<String?> requestOtp(String email) async {
    final callable = _functions.httpsCallable('requestOtp');
    final result = await callable.call({'email': email});
    final data = result.data;
    if (data is Map && data['otp'] is String) {
      return data['otp'] as String;
    }
    return null;
  }

  Future<void> verifyOtpAndReset({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    final callable = _functions.httpsCallable('verifyOtpAndReset');
    await callable.call({
      'email': email,
      'otp': otp,
      'newPassword': newPassword,
    });
  }
}
