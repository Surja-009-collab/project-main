import 'package:flutter/material.dart';
import 'package:project/Authentication/auth_state.dart';
import 'package:project/screens/drawer.dart';
import 'package:project/screens/help_support.dart';

class ProfilePages extends StatelessWidget {
  const ProfilePages({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    // Dummy user data
    const user = {
      'name': 'Surja Bist',
      'email': 'surja@example.com',
      'phone': '+91 9876543210',
      'image': 'assets/images/profile.jpg', // Make sure this asset exists
    };

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: AppBar(
        // title: const Text('My Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset('assets/images/logo.jpeg', width: 36, height: 36),
        ),
        title: RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: 'E',
                style: TextStyle(color: Color(0xFF23223A)),
              ),
              TextSpan(
                text: 'v',
                style: TextStyle(color: Color(0xFF1CCFCF)),
              ),
              TextSpan(
                text: 'entify',
                style: TextStyle(color: Color(0xFF23223A)),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      endDrawer: const AppDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(user['image']!),
              ),
              const SizedBox(height: 20),
              Text(
                user['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user['email']!,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Text(
                user['phone']!,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 4.0),
                  leading: const Icon(Icons.settings, color: Colors.purple),
                  title: const Text('Account Settings'),
                  onTap: () {
                    // Implement edit profile navigation
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: const Text('Personal Information'),
                onTap: () {
                  Navigator.pushNamed(context, '/personal_info');

                  // Implement change password navigation
                },
              ),
              ListTile(
                leading: const Icon(Icons.security, color: Colors.blue),
                title: const Text('Privacy & Security'),
                onTap: () {
                  Navigator.pushNamed(context, '/privacy_security');
                  // Implement logout logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.payment, color: Colors.blue),
                title: const Text('Payments'),
                onTap: () {
                  Navigator.pushNamed(context, '/payment_screen');
                  // Implement logout logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.blue),
                title: const Text('Contact Support'),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.pushNamed(context, '/contact_us');
                  // Implement logout logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.blue),
                title: const Text('Help & Support'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelpSupportScreen()),
                  );
                  // Implement logout logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout'),
                onTap: () {
                  AuthState.logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF8F5CFF),
        unselectedItemColor: const Color.fromARGB(255, 73, 73, 73),
        currentIndex: 4,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/search');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/booking');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/favourites');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
