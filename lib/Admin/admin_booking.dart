import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class AdminBookingsPage extends StatefulWidget {
  const AdminBookingsPage({super.key});

  @override
  State<AdminBookingsPage> createState() => _AdminBookingsPageState();
}

class _AdminBookingsPageState extends State<AdminBookingsPage> {
  // Loaded from local SQLite DB
  List<Map<String, dynamic>> bookings = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initAndLoad();
  }

  Future<void> _initAndLoad() async {
    await _loadBookings();
  }

  Future<void> _loadBookings() async {
    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('getAllBookings');
      final result = await callable.call();
      final data = result.data;
      final List<dynamic> list = (data is Map && data['bookings'] is List)
          ? data['bookings'] as List
          : [];
      setState(() {
        bookings = List<Map<String, dynamic>>.from(
            list.map((e) => Map<String, dynamic>.from(e as Map)));
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load bookings: $e')),
        );
      }
    }
  }

  // Function to approve or reject booking
  void _updateStatus(int index, String newStatus) async {
    final id = (bookings[index]["id"] ?? '').toString();
    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('updateBookingStatus');
      await callable.call({
        'id': id,
        'status': newStatus,
      });
      await _loadBookings();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update: $e')),
        );
      }
    }
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
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final upcomingBookings =
        bookings.where((b) => _isUpcoming(b["date"] as String)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Bookings"),
        backgroundColor: Colors.blue,
      ),
      body: RefreshIndicator(
        onRefresh: _loadBookings,
        child: ListView(
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
      ),
    );
  }
}
