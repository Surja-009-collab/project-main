import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventify',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const EventifyScreen(),
    );
  }
}

class EventifyScreen extends StatelessWidget {
  const EventifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Image.asset(
              'assets/images/logo.jpeg',
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),

            // Custom Eventify text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'E',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF23223A),
                  ),
                ),
                Text(
                  'v',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1CCFCF),
                  ),
                ),
                Text(
                  'ent',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF23223A),
                  ),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Text(
                        'i',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF23223A),
                        ),
                      ),
                    ),
                    // Arrow above 'i'
                    Positioned(
                      top: -18,
                      child: Icon(
                        Icons.arrow_drop_up,
                        color: Color(0xFFFFA726),
                        size: 28,
                      ),
                    ),
                  ],
                ),
                Text(
                  'fy',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF23223A),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}