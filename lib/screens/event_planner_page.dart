import 'package:flutter/material.dart';

class EventPlannerPage extends StatelessWidget {
  const EventPlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Planners'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find the perfect planner for your event',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            _buildPlannerCategories(),
            const SizedBox(height: 30),
            _buildFeaturedPlanners(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlannerCategories() {
    final categories = [
      {'icon': Icons.cake, 'label': 'Birthday'},
      {'icon': Icons.favorite, 'label': 'Wedding'},
      {'icon': Icons.business, 'label': 'Corporate'},
      {'icon': Icons.music_note, 'label': 'Concerts'},
      {'icon': Icons.emoji_events, 'label': 'Award Shows'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue[50],
                  child: Icon(
                    categories[index]['icon'] as IconData,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  categories[index]['label'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedPlanners() {
    final planners = [
      {
        'name': 'Dream Events Co.',
        'specialty': 'Wedding & Corporate',
        'rating': '4.9',
        'events': '120+ Events',
        'image': 'assets/images/planner1.jpeg',
      },
      {
        'name': 'Elite Planning',
        'specialty': 'Birthday & Parties',
        'rating': '4.7',
        'events': '80+ Events',
        'image': 'assets/images/planner2.jpeg',
      },
      {
        'name': 'Grand Occasions',
        'specialty': 'Corporate Events',
        'rating': '4.8',
        'events': '150+ Events',
        'image': 'assets/images/planner3.jpeg',
      },
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: planners.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(planners[index]['image']!),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          planners[index]['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(planners[index]['specialty']!),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            Text(planners[index]['rating']!),
                            const SizedBox(width: 16),
                            const Icon(Icons.event, size: 16),
                            Text(planners[index]['events']!),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () {
                      // Navigate to planner details
                    },
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