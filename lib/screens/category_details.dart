import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/screens/bookvenue.dart';

class CategoryDetailsPage extends StatelessWidget {
  final String categoryName;
  final String imageAsset;
  final String heroTag;

  const CategoryDetailsPage({
    Key? key,
    required this.categoryName,
    required this.imageAsset,
    String? heroTag,
  })  : heroTag = heroTag ?? imageAsset,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // transparent AppBar (keeps look like the mockups)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(categoryName, style: GoogleFonts.poppins(color: Colors.black87)),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
      color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Banner with Hero image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        Hero(
                          tag: heroTag,
                          child: Image.asset(
                            imageAsset,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: ElevatedButton.icon(
                            onPressed: () {
                                Navigator.push(
                                       context,
                             MaterialPageRoute(
                        builder: (context) => VenueBookingPage(),
                     ),
                    );
                   },
                            icon: const Icon(Icons.arrow_forward_ios, size: 14),
                            label: const Text('Book now!!'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // Title + description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Experience the Best $categoryName',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF23223A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Whether it\'s a small private event or a large celebration, find top planners, vendors and venues for $categoryName.',
                        style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Icon action row (Venues, Catering, Music, Photography...)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _IconAction(icon: Icons.place, label: 'Venues',
                      
                      ),
                      _IconAction(icon: Icons.restaurant, label: 'Catering'),
                      _IconAction(icon: Icons.music_note, label: 'Music'),
                      _IconAction(icon: Icons.auto_awesome, label: 'Decoration'),
                      _IconAction(icon: Icons.photo_camera, label: 'Photography'),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Browse Categories header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Browse Categories', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {},
                        child: Text('View All', style: GoogleFonts.poppins(color: const Color.fromARGB(255, 250, 121, 1))),
                      )
                    ],
                  ),
                ),

                // horizontal browse cards
                SizedBox(
                  height: 170,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    children: [
                      _BrowseCard(title: 'Royal Wedding', image: 'assets/images/balloon1.jpeg', rating: 4.9),
                      _BrowseCard(title: 'Beach Weddings', image: 'assets/images/wedding.jpg', rating: 4.2),
                      _BrowseCard(title: 'Garden Celebrations', image: 'assets/images/conference.jpeg', rating: 4.6),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Featured Planners
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Featured Planners', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextButton(onPressed: () {}, child: Text('View All', style: GoogleFonts.poppins(color: const Color.fromARGB(255, 250, 121, 1)))),
                    ],
                  ),
                ),

                SizedBox(
                  height: 180,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    children: const [
                      _PlannerCard(name: 'Kavya Bhat',  image: 'assets/images/team1.jpeg',rating: 4.8),
                      _PlannerCard(name: 'Rohit Oberoi', image: 'assets/images/team2.jpeg', rating: 4.6),
                      _PlannerCard(name: 'Elegant Events', image: 'assets/images/team3.jpeg', rating: 4.7),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Testimonials
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Testimonials', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const _TestimonialCard(
                        text: 'Absolutely fantastic! The party was a blast, and the planning process was smooth and professional.',
                        image: 'assets/images/team1.jpeg',
                        name: 'Anita Sharma',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- Helper Widgets ----------------

class _IconAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _IconAction({required this.icon, required this.label, this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0,2))],
            ),
            child: Icon(icon, size: 26, color: const Color(0xFF8F5CFF)),
          ),
          const SizedBox(height: 6),
          Text(label, style: GoogleFonts.poppins(fontSize: 12)),
        ],
      ),
    );
  }
}

class _BrowseCard extends StatelessWidget {
  final String title;
  final String image;
  final double rating;
  const _BrowseCard({required this.title, required this.image, required this.rating, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, width: double.infinity, height: 70, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.amber[700]),
                    const SizedBox(width: 4),
                    Text(rating.toString(), style: GoogleFonts.poppins(fontSize: 12)),
                    const Spacer(),
                    TextButton(onPressed: () {}, child: const Text('View Details', style: TextStyle(fontSize: 12))),
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class _PlannerCard extends StatelessWidget {
  final String name;
  final double rating;
  final String? image;
  const _PlannerCard({required this.name, required this.rating, required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            children: [
              CircleAvatar(radius: 22, backgroundImage: AssetImage(image ?? 'assets/images/team1.jpeg'),),
              const SizedBox(height: 8),
              Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 4),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.star, size: 14, color: Colors.amber[700]),
                const SizedBox(width: 4),
                Text(rating.toString(), style: GoogleFonts.poppins(fontSize: 12)),
              ]),
              const SizedBox(height: 6),
              ElevatedButton(onPressed: () {}, child: const Text('View More'), style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6)))
            ],
          ),
        ),
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String text;
  final String image;
  final String name;
  const _TestimonialCard({required this.text, required this.image, required this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(children: [
          Image.asset('assets/images/team1.jpeg', width: 80, height: 80, fit: BoxFit.cover),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(text, style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
          ]))
        ]),
      ),
    );
  }
}
