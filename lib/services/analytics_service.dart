import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// SCREEN VIEW
  Future<void> logScreenView(String screenName) async {
    await _analytics.logEvent(
      name: "screen_view",
      parameters: {
        "screen_name": screenName,
        "screen_class": screenName,
      },
    );
  }

  /// SIMPLE EVENT (NO CAST, NO CONVERSION)
 Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
  await _analytics.logEvent(
    name: name,
    parameters: parameters,
  );
}

  /// LOGIN
  Future<void> logLogin(String method) async {
    await _analytics.logEvent(
      name: "login",
      parameters: {"method": method},
    );
  }

  /// SIGNUP
  Future<void> logSignUp(String method) async {
    await _analytics.logEvent(
      name: "sign_up",
      parameters: {"method": method},
    );
  }

  /// DEBUG MESSAGE
  Future<void> logMessage(String message) async {
    await _analytics.logEvent(
      name: "debug_log",
      parameters: {"message": message},
    );
  }
}
