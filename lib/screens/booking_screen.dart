import 'package:flutter/material.dart';
import 'package:project/screens/booking_detail.dart';
import 'package:project/screens/drawer.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

// int _currentIndex = 2; // Bookings

  @override
  Widget build(BuildContext context) {
        final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // Dummy booking data
    final bookings = [
      {
        'venue': 'Grand Palace Hall',
        'date': '2025-10-12',
        'image': 'assets/images/venue1.jpeg',
        'status': 'Confirmed',
      },
      {
        'venue': 'Sunset Banquet',
        'date': '2025-11-05',
        'image': 'assets/images/venue2.jpeg',
        'status': 'Pending',
      },
            {
        'venue': 'Royal Place',
        'date': '2025-10-05',
        'image': 'assets/images/venue3.jpeg',
        'status': 'Pending',
      },
            {
        'venue': 'Heritage Garden',
        'date': '2024-11-05',
        'image': 'assets/images/mandap2.jpeg',
        'status': 'Confirmed',
      },
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(

      ),
    //  endDrawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset('assets/images/logo.jpeg', width: 36, height: 36),
        ),
        title: RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: 'E', style: TextStyle(color: Color(0xFF23223A))),
              TextSpan(text: 'v', style: TextStyle(color: Color(0xFF1CCFCF))),
              TextSpan(text: 'entify', style: TextStyle(color: Color(0xFF23223A))),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      endDrawer: const AppDrawer(),
      
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  booking['image']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                booking['venue']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Date: ${booking['date']}\nStatus: ${booking['status']}',
              ),
              isThreeLine: true,
              onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingDetailPage(booking: booking),
      ),
    );
  },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF8F5CFF),
        unselectedItemColor: const Color.fromARGB(255, 73, 73, 73),
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/search');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/booking');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/favourites');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favourites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}