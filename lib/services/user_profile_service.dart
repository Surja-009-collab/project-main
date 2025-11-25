// lib/services/user_profile_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user's profile
  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return doc.data()?['profile'] as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      print('Error getting user profile: $e');
      return null;
    }
  }

  // Update user profile
  Future<bool> updateUserProfile(Map<String, dynamic> profileData) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'profile': profileData,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }

  // Get current user's auth info
  Map<String, String>? getCurrentUserAuthInfo() {
    final user = _auth.currentUser;
    if (user == null) return null;

    return {
      'email': user.email ?? 'No email',
      'displayName': user.displayName ?? 'No name',
      'emailVerified': user.emailVerified.toString(),
      'uid': user.uid,
    };
  }
}