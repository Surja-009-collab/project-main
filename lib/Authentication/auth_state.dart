// lib/Authentication/auth_state.dart
import 'package:flutter/foundation.dart';

class AuthState {
  static final ValueNotifier<bool> isLoggedIn = ValueNotifier<bool>(false);
  static final ValueNotifier<bool> isAdminLoggedIn = ValueNotifier<bool>(false);

  static void login() {
    isLoggedIn.value = true;
  }

  static void logout() {
    isLoggedIn.value = false;
  }

  static void adminLogin() {
    isAdminLoggedIn.value = true;
  }

  static void adminLogout() {
    isAdminLoggedIn.value = false;
  }
}