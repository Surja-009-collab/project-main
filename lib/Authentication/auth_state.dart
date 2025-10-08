import 'package:flutter/foundation.dart';

class AuthState {
  // Simple global auth flag for demo. Replace with secure auth in production.
  static final ValueNotifier<bool> isLoggedIn = ValueNotifier<bool>(false);
  // Separate admin auth flag
  static final ValueNotifier<bool> isAdminLoggedIn = ValueNotifier<bool>(false);

  static void login() {
    isLoggedIn.value = true;
  }

  static void logout() {
    isLoggedIn.value = false;
  }

  // Admin-specific auth helpers
  static void adminLogin() {
    isAdminLoggedIn.value = true;
  }

  static void adminLogout() {
    isAdminLoggedIn.value = false;
  }
}
