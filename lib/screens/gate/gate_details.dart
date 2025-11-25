import 'package:flutter/material.dart';
import 'package:project/Authentication/auth_state.dart';
import 'package:project/screens/bookvenue.dart';

class GateDetailsPage extends StatelessWidget {
  final String image, name, price, capacity, location;

  const GateDetailsPage({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.capacity,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(image, width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  top: 16,
                  right: 16,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() => isFavorite = !isFavorite);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("📍 Location: $location",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("💰 Price: ₹ $price",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("👥 Capacity: $capacity people",
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
                                builder: (context) => const VenueBookingPage()),
                          );
                        } else {
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      },
                      child: const Text("Book Gate",
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
