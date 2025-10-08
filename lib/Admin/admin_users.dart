
import 'package:flutter/material.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  // Local list of users (dummy data)
  List<Map<String, dynamic>> users = [
    {"id": 1, "name": "Rima Shah", "email": "rima@example.com", "role": "User"},
    {"id": 2, "name": "Arjun Patel", "email": "arjun@example.com", "role": "User"},
    {"id": 3, "name": "Neha Gupta", "email": "neha@example.com", "role": "User"},
  ];

  // Add/Edit User Dialog
  void _showUserDialog({Map<String, dynamic>? user, int? index}) {
    final TextEditingController nameController =
        TextEditingController(text: user?["name"] ?? "");
    final TextEditingController emailController =
        TextEditingController(text: user?["email"] ?? "");
    String selectedRole = user?["role"] ?? "User";

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user == null ? "Add User" : "Edit User"),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Name is required" : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedRole,
                items: const [
                  DropdownMenuItem(value: "User", child: Text("User")),
                  DropdownMenuItem(value: "Planner", child: Text("Planner")),
                ],
                onChanged: (value) {
                  selectedRole = value!;
                },
                decoration: const InputDecoration(labelText: "Role"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text(user == null ? "Add" : "Update"),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  if (user == null) {
                    // Add new user
                    users.add({
                      "id": users.length + 1,
                      "name": nameController.text,
                      "email": emailController.text,
                      "role": selectedRole,
                    });
                  } else {
                    // Update existing user
                    users[index!] = {
                      "id": user["id"],
                      "name": nameController.text,
                      "email": emailController.text,
                      "role": selectedRole,
                    };
                  }
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  // Delete User
  void _deleteUser(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete User"),
        content: const Text("Are you sure you want to delete this user?"),
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
                users.removeAt(index);
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
        title: const Text("Manage Users"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            
            DataColumn(label: Text("ID")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("Role")),
            DataColumn(label: Text("Actions")),
          ],
          rows: List.generate(users.length, (index) {
            final user = users[index];
            return DataRow(cells: [
              DataCell(Text(user["id"].toString())),
              DataCell(Text(user["name"])),
              DataCell(Text(user["email"])),
              DataCell(Text(user["role"])),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showUserDialog(user: user, index: index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteUser(index),
                    ),
                  ],
                ),
              ),
            ]);
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () => _showUserDialog(),
      ),
    );
  }
}
