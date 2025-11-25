// lib/screens/book_venue_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/repositories/booking_repository.dart';

class BookVenueScreen extends StatefulWidget {
  final String venueId;
  final String venueName;

  const BookVenueScreen({
    super.key,
    required this.venueId,
    required this.venueName,
  });

  @override
  _BookVenueScreenState createState() => _BookVenueScreenState();
}

class _BookVenueScreenState extends State<BookVenueScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _guestsController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bookingRepo = Provider.of<BookingRepository>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Book ${widget.venueName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Event Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    _dateController.text = date.toString().split(' ')[0];
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _guestsController,
                decoration: const InputDecoration(
                  labelText: 'Number of Guests',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter number of guests';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : () => _bookVenue(bookingRepo),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _bookVenue(BookingRepository bookingRepo) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await bookingRepo.createBooking({
        'venueId': widget.venueId,
        'venueName': widget.venueName,
        'bookingDate': _dateController.text,
        'numberOfGuests': int.parse(_guestsController.text),
        'status': 'pending',
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking request sent successfully!')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _guestsController.dispose();
    super.dispose();
  }
}