import 'package:flutter/material.dart';
import 'package:project/screens/gate/gate_details.dart';

class ManageGatesPage extends StatefulWidget {
  const ManageGatesPage({super.key});

  @override
  State<ManageGatesPage> createState() => _ManageGatesPageState();
}

class _ManageGatesPageState extends State<ManageGatesPage> {
  List<Map<String, dynamic>> gates = [
    {
      "name": "Grand Entrance Gate",
      "location": "Ahmedabad, Gujarat",
      "price": 5000,
      "capacity": 200,
      "image": "assets/images/gate1.jpeg",
    },
    {
      "name": "Royal Welcome Gate",
      "location": "Delhi, India",
      "price": 7000,
      "capacity": 300,
      "image": "assets/images/gate2.jpeg",
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

  void deleteGate(int index) {
    setState(() {
      gates.removeAt(index);
    });
  }

  void addGate(Map<String, dynamic> gate) {
    setState(() {
      gates.add(gate);
    });
  }

  void updateGate(int index, Map<String, dynamic> gate) {
    setState(() {
      gates[index] = gate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Gates"),
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
        itemCount: gates.length,
        itemBuilder: (context, index) {
          final gate = gates[index];
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
                        gate["image"],
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
                      Text(gate["name"],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("📍 ${gate["location"]}"),
                      Text("💰 Price: ₹${gate["price"]}"),
                      Text("👥 Capacity: ${gate["capacity"]}"),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
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
                                onPressed: () => deleteGate(index),
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
    final gate = isUpdate
        ? gates[index]
        : {"name": "", "location": "", "price": 0, "capacity": 0, "image": ""};
    final nameController = TextEditingController(text: gate["name"]);
    final locationController = TextEditingController(text: gate["location"]);
    final priceController =
        TextEditingController(text: gate["price"].toString());
    final capacityController =
        TextEditingController(text: gate["capacity"].toString());
    final imageController = TextEditingController(text: gate["image"]);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? "Update Gate" : "Add Gate"),
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

              final newGate = {
                "name": nameController.text.trim(),
                "location": locationController.text.trim(),
                "price": int.parse(priceController.text.trim()),
                "capacity": int.parse(capacityController.text.trim()),
                "image": imageController.text.trim(),
              };

              if (isUpdate) {
                updateGate(index, newGate);
              } else {
                addGate(newGate);
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
