// lib/services/database_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add this method for getting user bookings
  Stream<QuerySnapshot> getUserBookings(String userId) {
    return _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  // Add this method for creating a booking
  Future<void> createBooking(Map<String, dynamic> bookingData) async {
    await _firestore.collection('bookings').add(bookingData);
  }

  // Add this getter for bookings collection
  CollectionReference get bookings => _firestore.collection('bookings');
}