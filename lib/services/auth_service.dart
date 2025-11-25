import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final _auth = FirebaseAuth.instance;

  Future<UserCredential> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await cred.user?.updateDisplayName(displayName);
    await cred.user?.reload();
    await cred.user?.sendEmailVerification();
    return cred;
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred;
  }

  Future<void> resendVerificationEmail() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<bool> refreshAndCheckVerified() async {
    final user = _auth.currentUser;
    await user?.reload();
    return _auth.currentUser?.emailVerified ?? false;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
