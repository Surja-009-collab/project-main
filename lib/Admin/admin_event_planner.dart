
import 'package:flutter/material.dart';

class AdminEventPlannerPage extends StatefulWidget {
  const AdminEventPlannerPage({super.key});

  @override
  State<AdminEventPlannerPage> createState() => _AdminEventPlannerPageState();
}

class _AdminEventPlannerPageState extends State<AdminEventPlannerPage> {
  // Dummy data (replace with DB/API later)
  List<Map<String, dynamic>> planners = [
    {
      "name": "Elegant Events",
      "phone": "9876543210",
      "email": "elegant@example.com",
      "location": "Delhi",
      "description": "Specialized in weddings and corporate events"
    },
    {
      "name": "Royal Planners",
      "phone": "9123456780",
      "email": "royal@example.com",
      "location": "Mumbai",
      "description": "Expert in birthday parties and engagements"
    },
  ];

  // Function to validate Email
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Function to add/edit event planner
  void _showPlannerDialog({Map<String, dynamic>? planner, int? index}) {
    final formKey = GlobalKey<FormState>();

    final TextEditingController nameController =
        TextEditingController(text: planner?["name"] ?? "");
    final TextEditingController phoneController =
        TextEditingController(text: planner?["phone"] ?? "");
    final TextEditingController emailController =
        TextEditingController(text: planner?["email"] ?? "");
    final TextEditingController locationController =
        TextEditingController(text: planner?["location"] ?? "");
    final TextEditingController descriptionController =
        TextEditingController(text: planner?["description"] ?? "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(planner == null ? "Add Event Planner" : "Edit Event Planner"),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Planner Name"),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter planner name" : null,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: "Phone"),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter phone number";
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return "Enter valid 10-digit phone number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter email";
                    if (!_isValidEmail(value)) return "Enter valid email";
                    return null;
                  },
                ),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: "Location"),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter location" : null,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                  maxLines: 2,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter description" : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text(planner == null ? "Add" : "Update"),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (planner == null) {
                  // Add new planner
                  setState(() {
                    planners.add({
                      "name": nameController.text,
                      "phone": phoneController.text,
                      "email": emailController.text,
                      "location": locationController.text,
                      "description": descriptionController.text,
                    });
                  });
                } else {
                  // Update planner
                  setState(() {
                    planners[index!] = {
                      "name": nameController.text,
                      "phone": phoneController.text,
                      "email": emailController.text,
                      "location": locationController.text,
                      "description": descriptionController.text,
                    };
                  });
                }
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  // Function to delete event planner with confirmation
  void _deletePlanner(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Planner"),
        content: const Text("Are you sure you want to delete this planner?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Delete"),
            onPressed: () {
              setState(() {
                planners.removeAt(index);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Event Planners"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: planners.length,
        itemBuilder: (context, index) {
          final planner = planners[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              title: Text(
                planner["name"],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone: ${planner["phone"]}"),
                  Text("Email: ${planner["email"]}"),
                  Text("Location: ${planner["location"]}"),
                  Text("About: ${planner["description"]}"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () =>
                        _showPlannerDialog(planner: planner, index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deletePlanner(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () => _showPlannerDialog(),
      ),
    );
  }
}
