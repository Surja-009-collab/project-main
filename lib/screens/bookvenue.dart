import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:cloud_functions/cloud_functions.dart';

class VenueBookingPage extends StatefulWidget {
  const VenueBookingPage({super.key});

  @override
  State<VenueBookingPage> createState() => _VenueBookingPageState();
}

class _VenueBookingPageState extends State<VenueBookingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bookingNoController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _couponController = TextEditingController();

  String? _selectedEventType;
  String? _selectedPlanner;
  DateTime? _selectedDate;

  final List<String> _eventTypes = [
    'Wedding',
    'Birthday',
    'Corporate Event',
    'Anniversary',
    'Baby Shower',
    'Reception',
  ];

  final List<String> _planners = [
    'Self Planning',
    'Professional Planner 1',
    'Professional Planner 2',
    'Professional Planner 3',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF8F5CFF)),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Book a Venue',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Book Your Dream Venue',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Booking Details Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Booking No
                      _buildTextField(
                        controller: _bookingNoController,
                        label: 'Booking No',
                        icon: Icons.confirmation_number_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter booking number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Name
                      _buildTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Mobile
                      _buildTextField(
                        controller: _mobileController,
                        label: 'Mobile Number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a valid mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Event Type Dropdown
                      _buildDropdown(
                        value: _selectedEventType,
                        label: 'Event Type',
                        icon: Icons.event_outlined,
                        items: _eventTypes,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedEventType = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select event type';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Planner Dropdown
                      _buildDropdown(
                        value: _selectedPlanner,
                        label: 'Planning Service',
                        icon: Icons.people_outline,
                        items: _planners,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedPlanner = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a planner option';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Booking Date
                      _buildDateField(context),
                      const SizedBox(height: 20),

                      // Amount
                      _buildTextField(
                        controller: _amountController,
                        label: 'Total Amount (₹)',
                        icon: Icons.currency_rupee,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter amount';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Offers Section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Special Offers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No offers available at the moment.',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(height: 1),
                      const SizedBox(height: 20),
                      Text(
                        'Have a coupon code?',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              controller: _couponController,
                              decoration: InputDecoration(
                                hintText: 'Enter coupon code',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF8F5CFF),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: _HoverButton(
                              onPressed: () {
                                // Apply coupon logic
                              },
                              child: const Text(
                                'Apply',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Book Now Button
              _HoverButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );

                  try {
                    final callable = FirebaseFunctions.instance
                        .httpsCallable('createBooking');
                    await callable.call({
                      'bookingNo': _bookingNoController.text.trim(),
                      'user': _nameController.text.trim(),
                      'phone': _mobileController.text.trim(),
                      'event': _selectedEventType,
                      'planner': _selectedPlanner,
                      'date': _selectedDate?.toIso8601String(),
                      'amount': _amountController.text.trim(),
                      'coupon': _couponController.text.trim(),
                    });
                    if (mounted) Navigator.of(context).pop();
                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Booking created. Await approval.'),
                        backgroundColor: Colors.green[600],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    if (mounted) Navigator.of(context).pop();
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to create booking: $e')),
                    );
                  }
                },
                isLarge: true,
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8F5CFF), width: 2),
        ),
        floatingLabelStyle: const TextStyle(color: Color(0xFF8F5CFF)),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String label,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8F5CFF), width: 2),
        ),
        floatingLabelStyle: const TextStyle(color: Color(0xFF8F5CFF)),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      dropdownColor: Colors.white,
      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF8F5CFF)),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        labelText: 'Booking Date',
        hintText: 'dd-mm-yyyy',
        labelStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        prefixIcon: Icon(
          Icons.calendar_today_outlined,
          color: Colors.grey[600],
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8F5CFF), width: 2),
        ),
        floatingLabelStyle: const TextStyle(color: Color(0xFF8F5CFF)),
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select booking date';
        }
        return null;
      },
    );
  }
}

// Custom Hover Button Widget
class _HoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final bool isLarge;

  const _HoverButton({
    required this.onPressed,
    required this.child,
    this.isLarge = false,
  });

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.isLarge ? double.infinity : null,
          padding: widget.isLarge
              ? const EdgeInsets.symmetric(vertical: 12, horizontal: 28)
              : const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          decoration: BoxDecoration(
            color: _isHovering
                ? Colors.white
                : const Color.fromARGB(255, 151, 95, 236),
            borderRadius: BorderRadius.circular(widget.isLarge ? 12 : 8),
            border: Border.all(color: const Color(0x0ff85cff), width: 2),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: const Color(0xFF8F5CFF).withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: widget.isLarge ? 16 : 14,
                fontWeight: FontWeight.bold,
                color: _isHovering ? const Color(0xFF8F5CFF) : Colors.white,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
