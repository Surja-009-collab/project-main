import 'package:flutter/material.dart';
import 'gate_details.dart';

class ViewAllGatePage extends StatefulWidget {
  const ViewAllGatePage({Key? key}) : super(key: key);

  @override
  State<ViewAllGatePage> createState() => _ViewAllGatePageState();
}

class _ViewAllGatePageState extends State<ViewAllGatePage> {
  final List<Map<String, dynamic>> gates = [
    {
      "name": "Royal Entrance Gate",
      "location": "Ahmedabad, Gujarat",
      "price": 5000,
      "capacity": 500,
      "image": "assets/images/gate1.jpeg",
      "isFavorite": false,
    },
    {
      "name": "Floral Arch Gate",
      "location": "Delhi, India",
      "price": 7000,
      "capacity": 700,
      "image": "assets/images/gate2.jpeg",
      "isFavorite": false,
    },
    {
      "name": "Golden Wedding Gate",
      "location": "Jaipur, Rajasthan",
      "price": 8500,
      "capacity": 600,
      "image": "assets/images/gate3.jpeg",
      "isFavorite": false,
    },
    {
      "name": "Modern LED Gate",
      "location": "Mumbai, Maharashtra",
      "price": 9000,
      "capacity": 800,
      "image": "assets/images/gate1.jpeg",
      "isFavorite": false,
    },
    {
      "name": "Traditional Indian Gate",
      "location": "Chennai, Tamil Nadu",
      "price": 6000,
      "capacity": 550,
      "image": "assets/images/gate2.jpeg",
      "isFavorite": false,
    },
    {
      "name": "Elegant Floral Gate",
      "location": "Kolkata, West Bengal",
      "price": 7500,
      "capacity": 650,
      "image": "assets/images/gate3.jpeg",
      "isFavorite": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Entrance Gates")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: gates.length,
        itemBuilder: (context, index) {
          final gate = gates[index];
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
                        gate["image"],
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: IconButton(
                          icon: Icon(
                            gate["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              gate["isFavorite"] = !gate["isFavorite"];
                            });
                          },
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
                      Text(gate["name"],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(gate["location"], style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("₹ ${gate["price"]}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                          Row(
                            children: [
                              const Icon(Icons.people, size: 18, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text("${gate["capacity"]}"),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          // Expanded(
                          //   child: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: const Color(0xFF8F5CFF),
                          //       foregroundColor: Colors.white,
                          //     ),
                          //     onPressed: () {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         const SnackBar(content: Text("Gate Selected!")),
                          //       );
                          //     },
                          //     child: const Text("Select"),
                          //   ),
                          // ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xFF8F5CFF),
                                side: const BorderSide(color: Color(0xFF8F5CFF)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GateDetailsPage(
                                      image: gate["image"],
                                      name: gate["name"],
                                      location: gate["location"],
                                      price: gate["price"].toString(),
                                      capacity: gate["capacity"].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Show Details"),
                            ),
                          ),
                        ],
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
