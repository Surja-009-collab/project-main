import 'package:flutter/material.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  int _selectedPaymentMethod = 0;
  bool _savePaymentInfo = true;

  // Sample payment methods
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'type': 'Credit Card',
      'icon': Icons.credit_card,
      'color': Colors.blue,
      'details': '**** **** **** 1234',
      'expiry': '12/25',
    },
    {
      'type': 'PayPal',
      'icon': Icons.account_balance_wallet,
      'color': Colors.blue[800],
      'details': 'user@example.com',
    },
    {
      'type': 'Bank Transfer',
      'icon': Icons.account_balance,
      'color': Colors.green,
      'details': 'HDFC Bank •••• 5678',
    },
    {
      'type': 'UPI',
      'icon': Icons.payment,
      'color': Colors.purple,
      'details': 'user@upi',
    },
  ];

  // Sample event bookings with payment details
  final List<Map<String, dynamic>> _eventBookings = [
    {
      'eventName': 'Wedding Planning',
      'eventType': 'Wedding',
      'date': 'Dec 15, 2023',
      'planner': 'Elite Wedding Planners',
      'amount': '₹1,75,000',
      'status': 'Paid',
      'statusColor': Colors.green,
      'paymentDate': 'Nov 15, 2023',
      'bookingId': 'EVT-789456',
      'installments': [
        {'amount': '₹75,000', 'date': 'Nov 15, 2023', 'status': 'Paid'},
        {'amount': '₹1,00,000', 'date': 'Dec 1, 2023', 'status': 'Due'},
      ],
    },
    {
      'eventName': 'Birthday Celebration',
      'eventType': 'Birthday',
      'date': 'Nov 30, 2023',
      'planner': 'Party Masters',
      'amount': '₹45,000',
      'status': 'Partial',
      'statusColor': Colors.orange,
      'paymentDate': 'Nov 5, 2023',
      'bookingId': 'EVT-123456',
      'installments': [
        {'amount': '₹15,000', 'date': 'Nov 5, 2023', 'status': 'Paid'},
        {'amount': '₹30,000', 'date': 'Nov 25, 2023', 'status': 'Due'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payments & Bookings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt, color: Colors.black87),
            onPressed: _viewPaymentReceipts,
            tooltip: 'View Payment Receipts',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats
            _buildStatsCard(),
            const SizedBox(height: 24),

            // Event Bookings Section
            _buildSectionHeader('Your Event Bookings'),
            const SizedBox(height: 16),
            ..._buildEventBookings(),

            const SizedBox(height: 24),

            // Payment Methods Section
            _buildSectionHeader('Payment Methods'),
            const SizedBox(height: 16),
            ..._buildPaymentMethods(),
            const SizedBox(height: 8),
            _buildAddPaymentMethod(),

            const SizedBox(height: 24),

            // Security Section
            _buildSecuritySection(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Function to view payment receipts
  void _viewPaymentReceipts() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.receipt_long, size: 48, color: Colors.blue),
                const SizedBox(height: 16),
                const Text(
                  'Payment Receipts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Download or view your payment receipts and invoices',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildReceiptOption('Wedding Planning Receipt', 'Nov 15, 2023'),
                _buildReceiptOption(
                  'Birthday Celebration Invoice',
                  'Nov 5, 2023',
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReceiptOption(String title, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
        title: Text(title, style: const TextStyle(fontSize: 14)),
        subtitle: Text(
          date,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: const Icon(Icons.download, size: 20, color: Colors.blue),
        onTap: () {
          // Simulate download
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Downloading $title'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                '₹2,20,000',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Total Spent',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Events',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Active',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: 0.5,
      ),
    );
  }

  List<Widget> _buildEventBookings() {
    return _eventBookings.map((booking) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ExpansionTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getEventColor(booking['eventType']).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getEventIcon(booking['eventType']),
              color: _getEventColor(booking['eventType']),
              size: 20,
            ),
          ),
          title: Text(
            booking['eventName'],
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          subtitle: Text(
            '${booking['date']} • ${booking['planner']}',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                booking['amount'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: booking['statusColor'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  booking['status'],
                  style: TextStyle(
                    color: booking['statusColor'],
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment Schedule',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  ...booking['installments'].map<Widget>((installment) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              installment['amount'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              installment['date'],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                installment['status'],
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              installment['status'],
                              style: TextStyle(
                                color: _getStatusColor(installment['status']),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Make payment
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Make Payment'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Color _getEventColor(String eventType) {
    switch (eventType) {
      case 'Wedding':
        return Colors.red;
      case 'Birthday':
        return Colors.blue;
      case 'Fashion Show':
        return Colors.purple;
      case 'Baby Shower':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  IconData _getEventIcon(String eventType) {
    switch (eventType) {
      case 'Wedding':
        return Icons.favorite;
      case 'Birthday':
        return Icons.cake;
      case 'Fashion Show':
        return Icons.style;
      case 'Baby Shower':
        return Icons.child_care;
      default:
        return Icons.event;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return Colors.green;
      case 'Due':
        return Colors.orange;
      case 'Pending':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  List<Widget> _buildPaymentMethods() {
    return _paymentMethods.map((method) {
      final index = _paymentMethods.indexOf(method);
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: _selectedPaymentMethod == index
              ? Border.all(color: Colors.blue, width: 1.5)
              : null,
        ),
        child: RadioListTile<int>(
          value: index,
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
          activeColor: Colors.blue,
          secondary: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: method['color'].withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(method['icon'], color: method['color'], size: 20),
          ),
          title: Text(
            method['type'],
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          subtitle: Text(
            method['details'],
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildAddPaymentMethod() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Colors.grey, size: 20),
        ),
        title: const Text(
          'Add Payment Method',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        onTap: _showAddPaymentMethod,
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.security, color: Colors.green, size: 22),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Payments',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(height: 4),
                Text(
                  'All transactions are encrypted and secure',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Professional Toggle Switch
          _ProfessionalToggle(
            value: _savePaymentInfo,
            onChanged: (value) {
              setState(() {
                _savePaymentInfo = value;
              });
            },
          ),
        ],
      ),
    );
  }

  void _showAddPaymentMethod() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Payment Method',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              _buildPaymentOption(Icons.credit_card, 'Credit/Debit Card'),
              _buildPaymentOption(Icons.account_balance_wallet, 'PayPal'),
              _buildPaymentOption(Icons.account_balance, 'Bank Transfer'),
              _buildPaymentOption(Icons.payment, 'UPI'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pop(context);
          // Navigate to specific payment method setup
        },
      ),
    );
  }
}

// Professional Toggle Switch Component
class _ProfessionalToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ProfessionalToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: value ? Colors.green : Colors.grey[300],
          border: Border.all(
            color: value ? Colors.green : Colors.grey[400]!,
            width: 1,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}