import 'package:flutter/material.dart';
import 'package:project/screens/bookvenue.dart';

class DecorationDetailsPage extends StatefulWidget {
  final String image, name, location, price, capacity;

  const DecorationDetailsPage({
    super.key,
    required this.image,
    required this.name,
    required this.location,
    required this.price,
    required this.capacity,
  });

  @override
  State<DecorationDetailsPage> createState() => _DecorationDetailsPageState();
}

class _DecorationDetailsPageState extends State<DecorationDetailsPage> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFavorite
            ? "${widget.name} added to favorites ❤️"
            : "${widget.name} removed from favorites 💔"),
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
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                  child: Image.asset(
                    widget.image,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
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
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("📍 Location: ${widget.location}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("💰 Price: ₹ ${widget.price}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("🎈 Setup Type: ${widget.capacity}",
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
                     Navigator.push(
                     context,
                     MaterialPageRoute(
                     builder: (context) => VenueBookingPage(),
                     ),
                  );
                  },
                      child: const Text("Book Decoration",
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
