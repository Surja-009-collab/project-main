import 'package:flutter/material.dart';

class VenuePage extends StatelessWidget {
  const VenuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venues'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSearchBar(),
          const SizedBox(height: 20),
          _buildCategorySection('Popular Venues'),
          const SizedBox(height: 20),
          _buildVenueList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search venues...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }

  Widget _buildCategorySection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCategoryChip('All', true),
              _buildCategoryChip('Wedding', false),
              _buildCategoryChip('Corporate', false),
              _buildCategoryChip('Birthday', false),
              _buildCategoryChip('Conference', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: Colors.blue,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
        onSelected: (bool selected) {},
      ),
    );
  }

  Widget _buildVenueList() {
    final venues = [
      {
        'name': 'Grand Palace Hall',
        'location': 'Surat, Gujarat',
        'price': '₹ 5,000',
        'rating': '4.8',
        'image': 'assets/images/venue1.jpeg',
      },
      {
        'name': 'Royal Garden',
        'location': 'Mumbai, Maharashtra',
        'price': '₹ 7,500',
        'rating': '4.5',
        'image': 'assets/images/venue2.jpeg',
      },
      {
        'name': 'Elegant Banquet',
        'location': 'Delhi',
        'price': '₹ 6,200',
        'rating': '4.7',
        'image': 'assets/images/venue3.jpeg',
      },
    ];

    return Column(
      children: venues.map((venue) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                venue['image']!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              venue['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(venue['location']!),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(venue['rating']!),
                    const Spacer(),
                    Text(
                      venue['price']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to venue details
            },
          ),
        );
      }).toList(),
    );
  }
}