import 'package:flutter/material.dart';
import 'package:project/screens/decoration/decoration_details.dart';

class ManageDecorationsPage extends StatefulWidget {
  const ManageDecorationsPage({super.key});

  @override
  State<ManageDecorationsPage> createState() => _ManageDecorationsPageState();
}

class _ManageDecorationsPageState extends State<ManageDecorationsPage> {
  List<Map<String, dynamic>> balloons = [
    {
      "name": "Golden Balloons",
      "location": "Ahmedabad, Gujarat",
      "price": 2000,
      "capacity": 100,
      "image": "assets/images/balloon1.jpeg",
    },
    {
      "name": "Floral Balloons",
      "location": "Delhi, India",
      "price": 2500,
      "capacity": 150,
      "image": "assets/images/balloon2.jpeg",
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

  void deleteBalloon(int index) {
    setState(() {
      balloons.removeAt(index);
    });
  }

  void addBalloon(Map<String, dynamic> balloon) {
    setState(() {
      balloons.add(balloon);
    });
  }

  void updateBalloon(int index, Map<String, dynamic> balloon) {
    setState(() {
      balloons[index] = balloon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Balloons"),
        backgroundColor: const Color(0xFF8F5CFF),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showAddOrUpdateDialog(context, null),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: balloons.length,
        itemBuilder: (context, index) {
          final balloon = balloons[index];
          final isFavorite = favoriteIndices.contains(index);

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
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
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
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
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("📍 ${balloon["location"]}"),
                      Text("💰 Price: ₹${balloon["price"]}"),
                      Text("👥 Capacity: ${balloon["capacity"]}"),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DecorationDetailsPage(
                                    image: balloon["image"],
                                    name: balloon["name"],
                                    location: balloon["location"],
                                    price: balloon["price"].toString(),
                                    capacity: balloon["capacity"].toString(),
                                  ),
                                ),
                              );
                            },
                            child: const Text("Show Details"),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () =>
                                    showAddOrUpdateDialog(context, index),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteBalloon(index),
                              ),
                            ],
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

  void showAddOrUpdateDialog(BuildContext context, int? index) {
    final isUpdate = index != null;
    final balloon = isUpdate
        ? balloons[index]
        : {"name": "", "location": "", "price": 0, "capacity": 0, "image": ""};
    final nameController = TextEditingController(text: balloon["name"]);
    final locationController = TextEditingController(text: balloon["location"]);
    final priceController =
        TextEditingController(text: balloon["price"].toString());
    final capacityController =
        TextEditingController(text: balloon["capacity"].toString());
    final imageController = TextEditingController(text: balloon["image"]);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? "Update Balloon" : "Add Balloon"),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Please enter a name'
                        : null),
                TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(labelText: "Location"),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Please enter a location'
                        : null),
                TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: "Price"),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Please enter a price';
                      }
                      final n = int.tryParse(v);
                      if (n == null || n <= 0) {
                        return 'Please enter a valid positive number';
                      }
                      return null;
                    }),
                TextFormField(
                    controller: capacityController,
                    decoration: const InputDecoration(labelText: "Capacity"),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Please enter capacity';
                      }
                      final n = int.tryParse(v);
                      if (n == null || n <= 0) {
                        return 'Please enter a valid positive number';
                      }
                      return null;
                    }),
                TextFormField(
                    controller: imageController,
                    decoration: const InputDecoration(labelText: "Image Path"),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Please provide an image path'
                        : null),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;

              final newBalloon = {
                "name": nameController.text.trim(),
                "location": locationController.text.trim(),
                "price": int.parse(priceController.text.trim()),
                "capacity": int.parse(capacityController.text.trim()),
                "image": imageController.text.trim(),
              };

              if (isUpdate) {
                updateBalloon(index, newBalloon);
              } else {
                addBalloon(newBalloon);
              }

              Navigator.pop(context);
            },
            child: Text(isUpdate ? "Update" : "Add"),
          ),
        ],
      ),
    );
  }
}
