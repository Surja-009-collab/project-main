import 'package:flutter/material.dart';
import 'decoration_details.dart';

class ViewAllDecorationPage extends StatefulWidget {
  // Add optional parameters for details navigation
  final String? image;
  final String? name;
  final String? location;
  final String? price;
  final String? capacity;

  const ViewAllDecorationPage({
    Key? key,
    this.image,
    this.name,
    this.location,
    this.price,
    this.capacity,
  }) : super(key: key);

  @override
  State<ViewAllDecorationPage> createState() => _ViewAllDecorationPageState();
}

class _ViewAllDecorationPageState extends State<ViewAllDecorationPage> {
  final List<Map<String, dynamic>> balloons = [
    {
      "name": "Rainbow Balloon Arch",
      "location": "Mumbai, India",
      "price": 3000,
      "capacity": "Medium Setup",
      "image": "assets/images/balloon1.jpeg",
    },
    {
      "name": "Golden Celebration Setup",
      "location": "Delhi, India",
      "price": 4500,
      "capacity": "Large Setup",
      "image": "assets/images/balloon2.jpeg",
    },
    {
      "name": "Pink & White Baby Shower",
      "location": "Bangalore, India",
      "price": 3500,
      "capacity": "Small Setup",
      "image": "assets/images/balloon3.jpeg",
    },
    {
      "name": "Elegant Party Decoration",
      "location": "Jaipur, India",
      "price": 5000,
      "capacity": "Large Setup",
      "image": "assets/images/balloon1.jpeg",
    },
  ];

  final Set<int> favoriteIndices = {};

  void toggleFavorite(int index) {
    setState(() {
      if (favoriteIndices.contains(index)) {
        favoriteIndices.remove(index);
      } else {
        favoriteIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // If details are passed, show details page
    if (widget.image != null &&
        widget.name != null &&
        widget.location != null &&
        widget.price != null &&
        widget.capacity != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Decoration Details")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.image!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(widget.name!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(widget.location!, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Text("₹ ${widget.price!}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
              const SizedBox(height: 8),
              Text("🎈 Setup Type: ${widget.capacity!}", style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    // Otherwise, show the list
    return Scaffold(
      appBar: AppBar(title: const Text("All Balloon Decorations")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: balloons.length,
        itemBuilder: (context, index) {
          final balloon = balloons[index];
          final isFavorite = favoriteIndices.contains(index);

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        balloon["image"],
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => toggleFavorite(index),
                        child: Container(
                          padding: const EdgeInsets.all(6),
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(balloon["name"],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(balloon["location"], style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text("₹ ${balloon["price"]}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                      const SizedBox(height: 8),
                      Text("🎈 Setup Type: ${balloon["capacity"]}",
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8F5CFF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DecorationDetailsPage(
                                  image: balloon["image"],
                                  name: balloon["name"],
                                  location: balloon["location"],
                                  price: balloon["price"].toString(),
                                  capacity: balloon["capacity"],
                                ),
                              ),
                            );
                          },
                          child: const Text("Show Details"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}