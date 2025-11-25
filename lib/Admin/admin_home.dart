import 'package:flutter/material.dart';
import 'package:project/Admin/admin_aboutus.dart';
import 'package:project/Admin/admin_setting_page.dart';
import 'package:project/Admin/manage_bookings.dart';
import 'package:project/Admin/manage_decorations.dart';
import 'package:project/Admin/manage_gates.dart';
import 'package:project/Admin/manage_mandap.dart';
import 'package:project/Admin/manage_stages.dart';
import 'package:project/Admin/manage_venue.dart';
import 'package:project/Authentication/auth_state.dart';
import 'package:project/Admin/admin_rating_review.dart';
import 'package:project/Admin/admin_coupons.dart';
import 'package:project/Admin/admin_event_planner.dart';
import 'package:project/Admin/admin_booking.dart';

// import 'package:project/screens/admin/manage_mandaps.dart';
// import 'package:project/screens/admin/manage_stages.dart';
// import 'package:project/screens/admin/manage_gates.dart';
// import 'package:project/screens/admin/manage_balloons.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Home"),
        backgroundColor: const Color(0xFF8F5CFF),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF8F5CFF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/logo.jpeg", // Replace with your logo
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Eventify Admin",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminHomePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Bookings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageBookingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.theater_comedy),
              title: const Text('Users'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminBookingsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Event Planners'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminEventPlannerPage()));
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text('Coupons'),
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCouponsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.reviews),
              title: const Text('Ratings & Reviews'),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => AdminReviewsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminSettingsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminAboutUsPage()));
              },
            ),
            const Divider(),
            ValueListenableBuilder<bool>(
              valueListenable: AuthState.isAdminLoggedIn,
              builder: (context, loggedIn, _) {
                if (!loggedIn) {
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text("Logout"),
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
                  );
                }
                return ListTile(
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
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            adminCard(context, "Venues", Icons.location_city, Colors.orange,
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManageVenuesPage()));
            }),
            adminCard(context, "Mandaps", Icons.event, Colors.green, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManageMandapsPage()));
            }),
            adminCard(context, "Stages", Icons.theater_comedy, Colors.blue, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManageStagesPage()));
            }),
            adminCard(context, "Gates", Icons.account_balance, Colors.red, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManageGatesPage()));
            }),
            adminCard(context, "Balloons", Icons.emoji_events, Colors.purple,
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManageDecorationsPage()));
            }),
          ],
        ),
      ),
    );
  }

  Widget adminCard(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
