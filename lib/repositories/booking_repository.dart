// lib/repositories/booking_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/services/database_service.dart';

class BookingRepository {
  final DatabaseService _database;

  BookingRepository(this._database);

  // Get all bookings for a specific user
  Stream<QuerySnapshot> getUserBookings(String userId) {
    return _database.getUserBookings(userId);
  }

  // Create a new booking
  Future<void> createBooking(Map<String, dynamic> bookingData) async {
    return await _database.createBooking(bookingData);
  }

  // Update a booking
  Future<void> updateBooking(String bookingId, Map<String, dynamic> data) async {
    await _database.bookings.doc(bookingId).update(data);
  }

  // Get a specific booking
  Future<DocumentSnapshot> getBooking(String bookingId) {
    return _database.bookings.doc(bookingId).get();
  }
}