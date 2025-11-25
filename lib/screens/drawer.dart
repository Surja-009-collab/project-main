import 'package:flutter/material.dart';
import 'package:project/Authentication/auth_state.dart';
import 'package:project/services/auth_service.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: AuthState.isLoggedIn,
        builder: (context, isLoggedIn, _) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(isLoggedIn ? "Surja Bist" : "Guest User"),
                accountEmail: Text(
                  isLoggedIn ? "surja@example.com" : "Please sign in",
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: isLoggedIn
                      ? const AssetImage("assets/images/profile.jpg")
                      : null,
                  child:
                      !isLoggedIn ? const Icon(Icons.person, size: 40) : null,
                ),
                decoration: BoxDecoration(color: Colors.blue.shade700),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: const Text("Venue"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/venue');
                },
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text("Event Planner"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/event_planner');
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text("Contact Us"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/contact_us');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("About Us"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/about_us');
                },
              ),
              const Divider(),
              if (!isLoggedIn) ...[
                ListTile(
                  leading: const Icon(Icons.login, color: Colors.green),
                  title: const Text("Sign In"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_add, color: Colors.blue),
                  title: const Text("Sign Up"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ] else ...[
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text("Logout"),
                  onTap: () async {
                    await AuthService.instance.logout();
                    AuthState.logout();
                    Navigator.pop(context);
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
