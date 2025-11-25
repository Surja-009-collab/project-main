import 'package:flutter/material.dart';
import 'package:project/screens/stage_detail.dart';

class AllStagesPage extends StatefulWidget {
  const AllStagesPage({super.key});

  @override
  State<AllStagesPage> createState() => _AllStagesPageState();
}

class _AllStagesPageState extends State<AllStagesPage> {
  final List<Map<String, dynamic>> stages = const [
    {
      "name": "Grand Royal Stage",
      "location": "Ahmedabad, Gujarat",
      "price": 8000,
      "halls": 1,
      "capacity": 700,
      "image": "assets/images/stage1.jpeg",
    },
    {
      "name": "Crystal Hall Stage",
      "location": "Delhi, India",
      "price": 12000,
      "halls": 2,
      "capacity": 1000,
      "image": "assets/images/stage2.jpeg",
    },
    {
      "name": "Classic Floral Stage",
      "location": "Mumbai, India",
      "price": 6000,
      "halls": 1,
      "capacity": 500,
      "image": "assets/images/stage3.jpeg",
    },
    {
      "name": "Fairy-Light Canopy Stage",
      "location": "Jaipur, Rajasthan",
      "price": 9000,
      "halls": 2,
      "capacity": 800,
      "image": "assets/images/stage1.jpeg",
    },
  ];

  final Set<int> favoriteIndices = {}; // Track favorites

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
      appBar: AppBar(title: const Text('All Stages')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: stages.length,
        itemBuilder: (context, index) {
          final stage = stages[index];
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
                // Stage Image
                 Stack(
                  children: [
                    ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    stage["image"],
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => toggleFavorite(index),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                           color: Colors.red,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Stage Info
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage["name"],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stage["location"],
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),

                      // Price, Halls, Capacity Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("₹ ${stage["price"]}",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                          Row(
                            children: [
                              const Icon(Icons.meeting_room, size: 18, color: Colors.purple),
                              const SizedBox(width: 4),
                              Text("${stage["halls"]}"),
                              const SizedBox(width: 12),
                              const Icon(Icons.people, size: 18, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text("${stage["capacity"]}"),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Button
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
                            // TODO: Add navigation to stage details
                                Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StageDetailsPage(
                                  image: stage["image"],
                                  name: stage["name"],
                                  location: stage["location"],
                                  price: stage["price"].toString(),
                                  halls: stage["halls"].toString(),
                                  capacity: stage["capacity"].toString(),
                                ),
                              ),
                            );
                          },
                          child: const Text("Select"),
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
