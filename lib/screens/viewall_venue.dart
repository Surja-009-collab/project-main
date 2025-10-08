import 'package:flutter/material.dart';
import 'package:project/screens/venue_details.dart';

class AllVenuesPage extends StatefulWidget {
  const AllVenuesPage({Key? key}) : super(key: key);

  @override
  State<AllVenuesPage> createState() => _AllVenuesPageState();
}

class _AllVenuesPageState extends State<AllVenuesPage> {
  final List<Map<String, dynamic>> venues = const [
    {
      "name": "Kwality Durbar Banquet",
      "location": "Surat, Gujarat",
      "price": 5000,
      "halls": 2,
      "capacity": 500,
      "image": "assets/images/venue1.jpeg",
    },
    {
      "name": "Heritage Garden",
      "location": "Patna, Bihar",
      "price": 7000,
      "halls": 3,
      "capacity": 300,
      "image": "assets/images/venue2.jpeg",
    },
    {
      "name": "Grand Palace Banquet",
      "location": "Delhi, India",
      "price": 6000,
      "halls": 2,
      "capacity": 400,
      "image": "assets/images/venue3.jpeg",
    },
    {
      "name": "Emerald Convention Center",
      "location": "Ahmedabad, Gujarat",
      "price": 8000,
      "halls": 4,
      "capacity": 700,
      "image": "assets/images/venue1.jpeg",
    },
    {
      "name": "Emerald Convention Center",
      "location": "Ahmedabad, Gujarat",
      "price": 8000,
      "halls": 4,
      "capacity": 700,
      "image": "assets/images/venue2.jpeg",
    },
  ];

  // Store favorite indices here
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
    return Scaffold(
      appBar: AppBar(title: const Text('All Venues')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final venue = venues[index];
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
                // Venue Image with Favorite Button
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        venue["image"],
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
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Venue Info
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        venue["name"],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        venue["location"],
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),

                      // Price, Halls, Capacity Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("₹ ${venue["price"]}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                          Row(
                            children: [
                              const Icon(Icons.meeting_room, size: 18, color: Colors.purple),
                              const SizedBox(width: 4),
                              Text("${venue["halls"]}"),
                              const SizedBox(width: 12),
                              const Icon(Icons.people, size: 18, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text("${venue["capacity"]}"),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Show Details Button
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
                                builder: (context) => VenueDetailsPage(
                                  image: venue["image"],
                                  name: venue["name"],
                                  location: venue["location"],
                                  price: venue["price"].toString(),
                                  halls: venue["halls"].toString(),
                                  capacity: venue["capacity"].toString(),
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
