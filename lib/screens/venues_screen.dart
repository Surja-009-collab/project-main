// lib/screens/venues_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/venue_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VenuesScreen extends StatelessWidget {
  const VenuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final venueRepo = Provider.of<VenueRepository>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Venues')),
      body: StreamBuilder<QuerySnapshot>(
        stream: venueRepo.getActiveVenues(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final venues = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: venues.length,
            itemBuilder: (context, index) {
              final venue = venues[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(venue['name'] ?? 'Unnamed Venue'),
                subtitle: Text(venue['location'] ?? ''),
                trailing: Text('\$${venue['price'] ?? 'N/A'}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add venue screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}