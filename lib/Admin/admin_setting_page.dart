import 'package:flutter/material.dart';
import 'package:project/Authentication/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool darkMode = false;
  bool notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('admin_name') ?? 'Admin User';
      emailController.text =
          prefs.getString('admin_email') ?? 'admin@email.com';
      passwordController.text = prefs.getString('admin_password') ?? '';
      darkMode = prefs.getBool('dark_mode') ?? false;
      notificationsEnabled = prefs.getBool('notifications') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('admin_name', nameController.text);
    await prefs.setString('admin_email', emailController.text);
    await prefs.setString('admin_password', passwordController.text);
    await prefs.setBool('dark_mode', darkMode);
    await prefs.setBool('notifications', notificationsEnabled);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved successfully!')),
    );
  }

  Future<void> _clearAboutUsData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('about_title');
    await prefs.remove('about_subtitle');
    await prefs.remove('about_story');
    await prefs.remove('feature1');
    await prefs.remove('feature2');
    await prefs.remove('feature3');
    await prefs.remove('feature4');
    await prefs.remove('stat1');
    await prefs.remove('stat2');
    await prefs.remove('stat3');
    await prefs.remove('stat4');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('About Us data cleared!')),
    );
  }

  void _logout() {
    // You can add your own navigation or login logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Settings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.blue),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Profile Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildTextField('Admin Name', nameController),
          const SizedBox(height: 10),
          _buildTextField('Email', emailController),
          const SizedBox(height: 10),
          _buildTextField('Password', passwordController, obscure: true),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          const Text(
            'Preferences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: notificationsEnabled,
            onChanged: (val) {
              setState(() => notificationsEnabled = val);
            },
            secondary: const Icon(Icons.notifications),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          const Text(
            'Data Management',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.cleaning_services, color: Colors.red),
            title: const Text('Clear About Us Data'),
            onTap: _clearAboutUsData,
          ),
          const SizedBox(height: 10),
          const Divider(),
          const Text(
            'Account',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () {
              AuthState.adminLogout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/admin_login',
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          label == 'Admin Name'
              ? Icons.person
              : label == 'Email'
                  ? Icons.email
                  : Icons.lock,
        ),
      ),
    );
  }
}
