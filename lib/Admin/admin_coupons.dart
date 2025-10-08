import 'package:flutter/material.dart';

class AdminCouponsPage extends StatefulWidget {
  const AdminCouponsPage({super.key});

  @override
  State<AdminCouponsPage> createState() => _AdminCouponsPageState();
}

class _AdminCouponsPageState extends State<AdminCouponsPage> {
  // Dummy coupons data (replace with DB/API data later)
  List<Map<String, dynamic>> coupons = [
    {"code": "SAVE10", "discount": "10%", "expiry": "2025-12-31"},
    {"code": "WELCOME20", "discount": "20%", "expiry": "2025-11-30"},
  ];

  // Function to validate date format
  bool _isValidDate(String date) {
    try {
      DateTime.parse(date);
      return true;
    } catch (_) {
      return false;
    }
  }

  // Function to add or edit coupon
  void _showCouponDialog({Map<String, dynamic>? coupon, int? index}) {
    final TextEditingController codeController =
        TextEditingController(text: coupon?["code"] ?? "");
    final TextEditingController discountController =
        TextEditingController(text: coupon?["discount"] ?? "");
    final TextEditingController expiryController =
        TextEditingController(text: coupon?["expiry"] ?? "");

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(coupon == null ? "Add Coupon" : "Edit Coupon"),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: codeController,
                decoration: const InputDecoration(labelText: "Coupon Code"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Coupon code is required";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: discountController,
                decoration: const InputDecoration(labelText: "Discount (e.g. 10%)"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Discount is required";
                  }
                  if (!RegExp(r'^\d+%$').hasMatch(value)) {
                    return "Enter a valid discount (e.g. 10%)";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: expiryController,
                decoration:
                    const InputDecoration(labelText: "Expiry Date (YYYY-MM-DD)"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Expiry date is required";
                  }
                  if (!_isValidDate(value)) {
                    return "Enter a valid date (YYYY-MM-DD)";
                  }
                  return null;
                },
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
            child: Text(coupon == null ? "Add" : "Update"),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (coupon == null) {
                  // Add new coupon
                  setState(() {
                    coupons.add({
                      "code": codeController.text,
                      "discount": discountController.text,
                      "expiry": expiryController.text,
                    });
                  });
                } else {
                  // Update existing coupon
                  setState(() {
                    coupons[index!] = {
                      "code": codeController.text,
                      "discount": discountController.text,
                      "expiry": expiryController.text,
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

  // Function to delete coupon
  void _deleteCoupon(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Coupon"),
        content: const Text("Are you sure you want to delete this coupon?"),
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
                coupons.removeAt(index);
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
        title: const Text("Manage Coupons"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          final coupon = coupons[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              title: Text(
                coupon["code"],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Discount: ${coupon["discount"]}"),
                  Text("Expiry: ${coupon["expiry"]}"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () =>
                        _showCouponDialog(coupon: coupon, index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteCoupon(index),
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
        onPressed: () => _showCouponDialog(),
      ),
    );
  }
}