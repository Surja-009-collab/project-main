import 'package:flutter/material.dart';

class ManageBookingsPage extends StatefulWidget {
  const ManageBookingsPage({super.key});

  @override
  State<ManageBookingsPage> createState() => _ManageBookingsPageState();
}

class _ManageBookingsPageState extends State<ManageBookingsPage> {
  List<Map<String, dynamic>> bookings = [
    {
      "id": "BK-1001",
      "customerName": "John Doe",
      "date": "2025-10-01",
      "status": "Confirmed",
      "amount": 5000,
    },
    {
      "id": "BK-1002",
      "customerName": "Jane Smith",
      "date": "2025-10-05",
      "status": "Pending",
      "amount": 3000,
    },
  ];

  void deleteBooking(int index) {
    setState(() {
      bookings.removeAt(index);
    });
  }

  void addBooking(Map<String, dynamic> booking) {
    setState(() {
      bookings.add(booking);
    });
  }

  void updateBooking(int index, Map<String, dynamic> booking) {
    setState(() {
      bookings[index] = booking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Bookings'),
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
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(
                '${booking['id']} • ${booking['customerName']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date: ${booking['date']}'),
                    Text('Status: ${booking['status']}'),
                    Text('Amount: ₹${booking['amount']}'),
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
                    onPressed: () => deleteBooking(index),
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
    final booking = isUpdate
        ? bookings[index]
        : {
            "id": "",
            "customerName": "",
            "date": "",
            "status": "Pending",
            "amount": 0,
          };

    final idController = TextEditingController(text: booking['id']);
    final customerController = TextEditingController(text: booking['customerName']);
    final dateController = TextEditingController(text: booking['date']);
    final statusController = TextEditingController(text: booking['status']);
    final amountController = TextEditingController(text: booking['amount'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? 'Update Booking' : 'Add Booking'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: idController, decoration: const InputDecoration(labelText: 'Booking ID')),
              TextField(controller: customerController, decoration: const InputDecoration(labelText: 'Customer Name')),
              TextField(controller: dateController, decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)')),
              TextField(controller: statusController, decoration: const InputDecoration(labelText: 'Status')),
              TextField(controller: amountController, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final newBooking = {
                'id': idController.text,
                'customerName': customerController.text,
                'date': dateController.text,
                'status': statusController.text,
                'amount': int.tryParse(amountController.text) ?? 0,
              };

              if (isUpdate) {
                updateBooking(index, newBooking);
              } else {
                addBooking(newBooking);
              }
              Navigator.pop(context);
            },
            child: Text(isUpdate ? 'Update' : 'Add'),
          ),
        ],
      ),
    );
  }
}
