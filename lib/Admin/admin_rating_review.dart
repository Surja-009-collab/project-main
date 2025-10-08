
import 'package:flutter/material.dart';

class AdminReviewsPage extends StatelessWidget {
  // Dummy data (replace this with API/Database data)
  final List<Map<String, dynamic>> reviews = [
    {
      "username": "John Doe",
      "rating": 4,
      "review": "Great experience! Booking was smooth.",
      "date": "2025-10-01"
    },
    {
      "username": "Rima Shah",
      "rating": 5,
      "review": "Loved the service, highly recommended!",
      "date": "2025-09-28"
    },
    {
      "username": "Amit Kumar",
      "rating": 3,
      "review": "It was okay, but can be improved.",
      "date": "2025-09-25"
    },
  ];

  AdminReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Ratings & Reviews"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    review["username"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    review["date"],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Row(
                    children: List.generate(
                      5,
                      (starIndex) => Icon(
                        starIndex < review["rating"]
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    review["review"],
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
