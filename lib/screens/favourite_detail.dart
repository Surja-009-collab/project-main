import 'package:flutter/material.dart';
import 'package:project/Authentication/auth_state.dart';
import 'package:project/screens/bookvenue.dart';

class FavouriteDetailPage extends StatelessWidget {
  final Map<String, String> fav;

  const FavouriteDetailPage({super.key, required this.fav});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Favourite Details",
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                fav['image']!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              fav['venue']!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Location: ${fav['location']}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "Price: ${fav['price']}",
              style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                if (AuthState.isLoggedIn.value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VenueBookingPage()),
                  );
                } else {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8F5CFF),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.event_available, color: Colors.white),
              label: const Text(
                "Book Now",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
