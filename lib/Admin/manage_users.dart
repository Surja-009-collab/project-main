import 'package:flutter/material.dart';

class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({super.key});

  @override
  State<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  List<Map<String, dynamic>> users = [
    {
      'name': 'Alice Johnson',
      'email': 'alice@example.com',
      'role': 'Customer',
      'active': true,
    },
    {
      'name': 'Bob Williams',
      'email': 'bob@example.com',
      'role': 'Planner',
      'active': false,
    },
  ];

  void deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  void addUser(Map<String, dynamic> user) {
    setState(() {
      users.add(user);
    });
  }

  void updateUser(int index, Map<String, dynamic> user) {
    setState(() {
      users[index] = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
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
        itemCount: users.length,
        itemBuilder: (context, index) {
          final u = users[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                child: Text((u['name'] as String).isNotEmpty ? (u['name'] as String)[0] : '?'),
              ),
              title: Text(
                u['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(u['email']),
                    Text('Role: ${u['role']} • Status: ${(u['active'] as bool) ? 'Active' : 'Inactive'}'),
                  ],
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => showAddOrUpdateDialog(context, index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteUser(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showAddOrUpdateDialog(BuildContext context, int? index) {
    final isUpdate = index != null;
    final user = isUpdate
        ? users[index]
        : {
            'name': '',
            'email': '',
            'role': 'Customer',
            'active': true,
          };

    final nameController = TextEditingController(text: user['name']);
    final emailController = TextEditingController(text: user['email']);
    final roleController = TextEditingController(text: user['role']);
    bool active = user['active'] as bool;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text(isUpdate ? 'Update User' : 'Add User'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
                TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
                TextField(controller: roleController, decoration: const InputDecoration(labelText: 'Role (Customer/Planner/Admin)')),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Active'),
                    const SizedBox(width: 8),
                    Switch(
                      value: active,
                      onChanged: (v) => setStateDialog(() => active = v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                final newUser = {
                  'name': nameController.text,
                  'email': emailController.text,
                  'role': roleController.text,
                  'active': active,
                };

                if (isUpdate) {
                  updateUser(index, newUser);
                } else {
                  addUser(newUser);
                }
                Navigator.pop(context);
              },
              child: Text(isUpdate ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
