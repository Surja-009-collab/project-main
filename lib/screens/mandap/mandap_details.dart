import 'package:flutter/material.dart';
import 'package:project/Authentication/auth_state.dart';
import 'package:project/screens/bookvenue.dart';

class MandapDetailsPage extends StatefulWidget {
  final String image, name, price, halls, capacity;

  const MandapDetailsPage({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.halls,
    required this.capacity,
  });

  @override
  State<MandapDetailsPage> createState() => _MandapDetailsPageState();
}

class _MandapDetailsPageState extends State<MandapDetailsPage> {
  bool isFavorite = false; // Track favorite state

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    // Optional: show a snackbar to confirm
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? "${widget.name} added to favorites ❤️"
              : "${widget.name} removed from favorites 💔",
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Image with rounded corners
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                  child: Image.asset(
                    widget.image,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),

                // Favorite Icon Positioned
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: toggleFavorite,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("💰 Price: ₹ ${widget.price}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("🏛️ Number of Halls: ${widget.halls}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("👥 Capacity: ${widget.capacity} people",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFF8F5CFF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        if (AuthState.isLoggedIn.value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VenueBookingPage(),
                            ),
                          );
                        } else {
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      },
                      child: const Text("Book Mandap",
                          style: TextStyle(fontSize: 18)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
