import 'package:flutter/material.dart';

class AdminBookingsPage extends StatefulWidget {
  const AdminBookingsPage({super.key});

  @override
  State<AdminBookingsPage> createState() => _AdminBookingsPageState();
}

class _AdminBookingsPageState extends State<AdminBookingsPage> {
  // Dummy booking data (replace with API/DB later)
  List<Map<String, dynamic>> bookings = [
    {
      "id": 1,
      "user": "Rima Shah",
      "event": "Wedding Reception",
      "date": "2025-10-10",
      "status": "Pending",
    },
    {
      "id": 2,
      "user": "Arjun Patel",
      "event": "Birthday Party",
      "date": "2025-10-15",
      "status": "Approved",
    },
    {
      "id": 3,
      "user": "Neha Gupta",
      "event": "Corporate Event",
      "date": "2025-09-30",
      "status": "Rejected",
    },
  ];

  // Function to approve or reject booking
  void _updateStatus(int index, String newStatus) {
    setState(() {
      bookings[index]["status"] = newStatus;
    });
  }

  // Check if booking is upcoming
  bool _isUpcoming(String date) {
    try {
      final bookingDate = DateTime.parse(date);
      return bookingDate.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final upcomingBookings =
        bookings.where((b) => _isUpcoming(b["date"])).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Bookings"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Upcoming Bookings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          if (upcomingBookings.isEmpty)
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("No upcoming bookings"),
            )
          else
            ...upcomingBookings.map((booking) {
              int index = bookings.indexOf(booking);
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: ListTile(
                  title: Text(
                    booking["event"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User: ${booking["user"]}"),
                      Text("Date: ${booking["date"]}"),
                      Text("Status: ${booking["status"]}"),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) => _updateStatus(index, value),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "Approved",
                        child: Text("Approve"),
                      ),
                      const PopupMenuItem(
                        value: "Rejected",
                        child: Text("Reject"),
                      ),
                      const PopupMenuItem(
                        value: "Pending",
                        child: Text("Mark as Pending"),
                      ),
                    ],
                    child: const Icon(Icons.more_vert),
                  ),
                ),
              );
            }),

          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "All Bookings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...bookings.map((booking) {
            int index = bookings.indexOf(booking);
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                title: Text(
                  booking["event"],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("User: ${booking["user"]}"),
                    Text("Date: ${booking["date"]}"),
                    Text("Status: ${booking["status"]}"),
                  ],
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) => _updateStatus(index, value),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: "Approved",
                      child: Text("Approve"),
                    ),
                    const PopupMenuItem(
                      value: "Rejected",
                      child: Text("Reject"),
                    ),
                    const PopupMenuItem(
                      value: "Pending",
                      child: Text("Mark as Pending"),
                    ),
                  ],
                  child: const Icon(Icons.more_vert),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}