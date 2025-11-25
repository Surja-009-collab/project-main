import 'package:flutter/material.dart';
import 'package:project/screens/mandap/mandap_details.dart';

class AllMandapsPage extends StatefulWidget {
  const AllMandapsPage({super.key});

  @override
  State<AllMandapsPage> createState() => _AllMandapsPageState();
}

class _AllMandapsPageState extends State<AllMandapsPage> {
  final List<Map<String, dynamic>> mandaps = const [
    {
      "name": "Golden Mandap",
      "price": 2000,
      "halls": 2,
      "capacity": 500,
      "image": "assets/images/mandap1.jpeg",
    },
    {
      "name": "Traditional Mandap",
      "price": 3000,
      "halls": 2,
      "capacity": 500,
      "image": "assets/images/mandap2.jpeg",
    },
    {
      "name": "Royal Mandap",
      "price": 4000,
      "halls": 2,
      "capacity": 500,
      "image": "assets/images/mandap3.jpeg",
    },
    {
      "name": "Elegant Mandap",
      "price": 3500,
      "halls": 2,
      "capacity": 500,
      "image": "assets/images/mandap1.jpeg",
    },
    {
      "name": "Floral Mandap",
      "price": 2500,
      "halls": 2,
      "capacity": 500,
      "image": "assets/images/mandap2.jpeg",
    },
    {
      "name": "Modern Mandap",
      "price": 4500,
      "halls": 2,
      "capacity": 500,
      "image": "assets/images/mandap3.jpeg",
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
    return Scaffold(
      appBar: AppBar(title: const Text('All Mandaps')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: mandaps.length,
        itemBuilder: (context, index) {
          final mandap = mandaps[index];
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
                        mandap["image"],
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mandap["name"],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text("₹ ${mandap["price"]}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                      const SizedBox(height: 12),
                       Text("🏛️ Number of Halls ${mandap["halls"]}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("👥 Capacity ${mandap["people"]}",
                      style: const TextStyle(fontSize: 16)),
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
                                builder: (context) => MandapDetailsPage(
                                  image: mandap["image"],
                                  name: mandap["name"],
                                  price: mandap["price"].toString(),
                                  halls: mandap["halls"].toString(),
                                  capacity: mandap["capacity"].toString(),
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
