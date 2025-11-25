import 'package:flutter/material.dart';
import 'package:project/screens/mandap/mandap_details.dart';

class ManageMandapsPage extends StatefulWidget {
  const ManageMandapsPage({super.key});

  @override
  State<ManageMandapsPage> createState() => _ManageMandapsPageState();
}

class _ManageMandapsPageState extends State<ManageMandapsPage> {
  List<Map<String, dynamic>> mandaps = [
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

  void deleteMandap(int index) {
    setState(() {
      mandaps.removeAt(index);
    });
  }

  void addMandap(Map<String, dynamic> mandap) {
    setState(() {
      mandaps.add(mandap);
    });
  }

  void updateMandap(int index, Map<String, dynamic> mandap) {
    setState(() {
      mandaps[index] = mandap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Mandaps"),
        backgroundColor: const Color(0xFF8F5CFF),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showAddOrUpdateDialog(context, null);
            },
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: mandaps.length,
        itemBuilder: (context, index) {
          final mandap = mandaps[index];
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
                      Text(mandap["name"],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("💰 Price: ₹${mandap["price"]}"),
                      Text("🏛️ Halls: ${mandap["halls"]}"),
                      Text("👥 Capacity: ${mandap["capacity"]}"),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
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
                                onPressed: () => deleteMandap(index),
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
    final mandap = isUpdate
        ? mandaps[index]
        : {"name": "", "price": 0, "halls": 0, "capacity": 0, "image": ""};
    final nameController = TextEditingController(text: mandap["name"]);
    final priceController =
        TextEditingController(text: mandap["price"].toString());
    final hallsController =
        TextEditingController(text: mandap["halls"].toString());
    final capacityController =
        TextEditingController(text: mandap["capacity"].toString());
    final imageController = TextEditingController(text: mandap["image"]);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? "Update Mandap" : "Add Mandap"),
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
                    controller: hallsController,
                    decoration: const InputDecoration(labelText: "Halls"),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Please enter number of halls';
                      }
                      final n = int.tryParse(v);
                      if (n == null || n < 0) {
                        return 'Please enter a valid number';
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

              final newMandap = {
                "name": nameController.text.trim(),
                "price": int.parse(priceController.text.trim()),
                "halls": int.parse(hallsController.text.trim()),
                "capacity": int.parse(capacityController.text.trim()),
                "image": imageController.text.trim(),
              };

              if (isUpdate) {
                updateMandap(index, newMandap);
              } else {
                addMandap(newMandap);
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
