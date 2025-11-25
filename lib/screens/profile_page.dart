// lib/screens/profile_page.dart
import 'package:flutter/material.dart';
import 'package:project/screens/edit_profile_page.dart';
import 'package:provider/provider.dart';
import 'package:project/services/user_profile_service.dart';
import 'package:project/Authentication/auth_state.dart';
import 'package:project/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserProfileService _profileService = UserProfileService();
  Map<String, dynamic>? _userProfile;
  Map<String, String>? _authInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final profile = await _profileService.getCurrentUserProfile();
      final authInfo = _profileService.getCurrentUserAuthInfo();

      if (mounted) {
        setState(() {
          _userProfile = profile ?? {};
          _authInfo = authInfo;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading profile: $e')),
        );
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await AuthService.instance.logout();
      if (mounted) {
        AuthState.logout();
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing out: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileSection('Account Information', [
                    _buildInfoRow('Name', _userProfile?['name'] ?? _authInfo?['displayName'] ?? 'Not set'),
                    _buildInfoRow('Email', _authInfo?['email'] ?? 'Not available'),
                    _buildInfoRow('Phone', _userProfile?['phone'] ?? 'Not set'),
                  ]),
                  const SizedBox(height: 20),
                  _buildProfileSection('Preferences', [
                    _buildInfoRow('Theme', _userProfile?['theme'] ?? 'System default'),
                    _buildInfoRow('Notifications', _userProfile?['notifications'] ?? 'Enabled'),
                  ]),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                     onPressed: () async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditProfilePage(
        currentProfile: _userProfile,
        authInfo: _authInfo ?? {},
      ),
    ),
  );
  
  if (result == true) {
    // Reload profile data if changes were made
    _loadUserData();
  }
},
                      child: const Text('Edit Profile'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}