// lib/repositories/venue_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class VenueRepository {
  final FirebaseFirestore _firestore;

  VenueRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<QuerySnapshot> getActiveVenues() {
    return _firestore
        .collection('venues')
        .where('isActive', isEqualTo: true)
        .orderBy('name')
        .snapshots();
  }

  Future<void> addVenue(Map<String, dynamic> venueData) async {
    await _firestore.collection('venues').add({
      ...venueData,
      'createdAt': FieldValue.serverTimestamp(),
      'isActive': true,
    });
  }

  Future<void> updateVenue(String venueId, Map<String, dynamic> updates) async {
    await _firestore.collection('venues').doc(venueId).update(updates);
  }
}