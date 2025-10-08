import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/screens/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project/screens/venue_details.dart';
import 'package:project/screens/category_details.dart';
import 'package:project/screens/viewall_stage.dart';
import 'package:project/screens/viewall_venue.dart';
import 'package:project/screens/mandap/viewall_mandap.dart';
import 'package:project/screens/gate/viewall_gate.dart';
import 'package:project/screens/decoration/viewall_decoration.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, String>> _bannerImages = [
    {
      'image': 'assets/images/banner1.jpg',
      'title': 'BOOK YOUR EVENTS',
      'subtitle': 'Your personal event planner in your pocket',
      'button': 'Plan in Ten Minutes'
    },
    {
      'image': 'assets/images/banner2.jpg',
      'title': 'FIND THE BEST VENUES',
      'subtitle': 'Discover top-rated spaces near you',
      'button': 'Browse Venues'
    },
    {
      'image': 'assets/images/banner3.jpg',
      'title': 'MAKE MEMORIES',
      'subtitle': 'Capture every moment of your big day',
      'button': 'Start Planning'
    },
  ];

  int _current = 0;
  int _currentIndex = 0; // 0 = Home, 1 = Search, …
  // int _selectedIndex = 0; // 0 = Home, 1 = Search, …

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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

      drawer: const AppDrawer(),

      // ---------------- BODY ----------------
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------- Carousel ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: _bannerImages.length,
                    itemBuilder: (context, index, _) {
                      final banner = _bannerImages[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              banner['image']!,
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              // color: Colors.black45,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    banner['title']!,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    banner['subtitle']!,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    icon: const Icon(Icons.arrow_forward_ios, size: 14),
                                    label: Text(banner['button']!),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      onPageChanged: (i, _) => setState(() => _current = i),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _bannerImages.asMap().entries.map((entry) {
                      return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == entry.key
                              ? Colors.pink
                              : Colors.grey.shade400,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ---------- Categories ----------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF23223A),
                ),
              ),
            ),
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Row(
    children: [
      _CategoryCard(
        label: 'Birthday Parties',
        imageAsset: 'assets/images/cake.jpg',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailsPage(
                categoryName: 'Birthday Parties',
                imageAsset: 'assets/images/cake.jpg',
              ),
            ),
          );
        },
      ),
      _CategoryCard(
        label: 'Wedding Ceremony',
        imageAsset: 'assets/images/wedding.jpg',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailsPage(
                categoryName: 'Wedding Ceremony',
                imageAsset: 'assets/images/wedding.jpg',
              ),
            ),
          );
        },
      ),
      // ... do this for all other categories
       _CategoryCard(
        label: 'Cocktail Parties',
        imageAsset: 'assets/images/cocktail.jpg',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailsPage(
                categoryName: 'Cocktail Parties',
                imageAsset: 'assets/images/cocktail.jpg',
              ),
            ),
          );
        },
      ),
 _CategoryCard(
        label: 'Fashion Shows',
        imageAsset: 'assets/images/fashion.jpg',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailsPage(
                categoryName: 'Fashion Show',
                imageAsset: 'assets/images/fashion.jpg',
              ),
            ),
          );
        },
      ),
    
 _CategoryCard(
        label: 'Baby Showers',
        imageAsset: 'assets/images/babyshower.jpeg',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailsPage(
                categoryName: 'Baby Showers',
                imageAsset: 'assets/images/babyshower.jpeg',
              ),
            ),
          );
        },
      ),
       _CategoryCard(
        label: 'Farewell Parties',
        imageAsset: 'assets/images/farewell.jpg',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailsPage(
                categoryName: 'Farewall Parties',
                imageAsset: 'assets/images/farewell.jpg',
              ),
            ),
          );
        },
      ),
       _CategoryCard(
        label: 'Conference Events',
        imageAsset: 'assets/images/conference.jpeg',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailsPage(
                categoryName: 'Conference Events',
                imageAsset: 'assets/images/conference.jpeg',
              ),
            ),
          );
        },
      ),
      ],
  ),
),
            const SizedBox(height: 24),

            // ---------- Top Venues ----------
            _SectionHeader(title: 'Top Venues',
            onViewAll: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllVenuesPage(),
                ),
              );
            },),
            const SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _VenueCard(
                    image: 'assets/images/venue1.jpeg',
                    name: 'Kwality Durbar Banquet',
                    location: 'Surat, Gujarat',
                    price: '₹ 5000',
                    halls: '2',
                    capacity: '500',
                  ),
                  _VenueCard(
                    image: 'assets/images/venue2.jpeg',
                    name: 'Heritage Garden',
                    location: 'Patna, Bihar',
                    price: '₹ 7000',
                    halls: '3',
                    capacity: '300',
                  ),
                  _VenueCard(
                    image: 'assets/images/venue3.jpeg',
                    name: 'Royal Place',
                    location: 'Pune, Mumbai',
                    price: '₹ 10000',
                    halls: '4',
                    capacity: '900',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

                        const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Decoration',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF23223A),
                ),
              ),
            ),

            // ---------- NEW: Top Stages ----------
            _SectionHeader(title: 'Stages',
              onViewAll: () {
            Navigator.push(
           context,
           MaterialPageRoute(
          builder: (context) => AllStagesPage(),
          ),
         );
         },
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _StageCard(
                    image: 'assets/images/stage1.jpeg',
                    name: 'Grand Royal Stage',
                    location: 'Ahmedabad, Gujarat',
                    price: '₹ 8000',
                    halls: '1',
                    capacity: '700',
                  ),
                  _StageCard(
                    image: 'assets/images/stage2.jpeg',
                    name: 'Crystal Hall Stage',
                    location: 'Delhi, India',
                    price: '₹ 12000',
                    halls: '2',
                    capacity: '1000',
                  ),
                  _StageCard(
                    image: 'assets/images/stage3.jpeg',
                    name: 'Sunset Garden Stage',
                    location: 'Jaipur, Rajasthan',
                    price: '₹ 9000',
                    halls: '1',
                    capacity: '600',
                  ),
                ],
              ),
            ),

const SizedBox(height: 24),

            // ---------- NEW: Mandap Decorations ----------
            _SectionHeader(title: 'Mandap Decorations',
              onViewAll: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllMandapsPage(),
      ),
    );
  },
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _StageCard(
                    image: 'assets/images/mandap1.jpeg',
                    name: 'Traditional Mandap',
                    location: 'Surat, Gujarat',
                    price: '₹ 15,000',
                    halls: '—',
                    capacity: '—',
                  ),
                  _StageCard(
                    image: 'assets/images/mandap2.jpeg',
                    name: 'Royal Wedding Mandap',
                    location: 'Jaipur, Rajasthan',
                    price: '₹ 20,000',
                    halls: '—',
                    capacity: '—',
                  ),
                  _StageCard(
                    image: 'assets/images/mandap3.jpeg',
                    name: 'Modern Floral Mandap',
                    location: 'Mumbai, Maharashtra',
                    price: '₹ 18,000',
                    halls: '—',
                    capacity: '—',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ---------- NEW: Entrance Gate Decorations ----------
            _SectionHeader(title: 'Entrance Gate Decorations',
              onViewAll: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewAllGatePage(),
      ),
    );
  },),
            const SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _StageCard(
                    image: 'assets/images/gate1.jpeg',
                    name: 'Royal Gate',
                    location: 'Delhi, India',
                    price: '₹ 10,000',
                    halls: '—',
                    capacity: '—',
                  ),
                  _StageCard(
                    image: 'assets/images/gate2.jpeg',
                    name: 'Floral Arch Gate',
                    location: 'Pune, Maharashtra',
                    price: '₹ 12,000',
                    halls: '—',
                    capacity: '—',
                  ),
                  _StageCard(
                    image: 'assets/images/gate3.jpeg',
                    name: 'Rustic Theme Gate',
                    location: 'Hyderabad, Telangana',
                    price: '₹ 9,000',
                    halls: '—',
                    capacity: '—',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ---------- NEW: Balloon Decorations ----------
            _SectionHeader(title: 'Balloon Decorations',
              onViewAll: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewAllDecorationPage(),
      ),
    );
  },
  ),
            const SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _StageCard(
                    image: 'assets/images/balloon1.jpeg',
                    name: 'Birthday Balloon Setup',
                    location: 'Kolkata, West Bengal',
                    price: '₹ 5,000',
                    halls: '—',
                    capacity: '—',
                  ),
                  _StageCard(
                    image: 'assets/images/balloon2.jpeg',
                    name: 'Anniversary Balloons',
                    location: 'Ahmedabad, Gujarat',
                    price: '₹ 6,500',
                    halls: '—',
                    capacity: '—',
                  ),
                  _StageCard(
                    image: 'assets/images/balloon3.jpeg',
                    name: 'Baby Shower Balloons',
                    location: 'Bangalore, Karnataka',
                    price: '₹ 7,000',
                    halls: '—',
                    capacity: '—',
                  ),
                ],
              ),
            ),

          ], // end Column children
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF8F5CFF),
        unselectedItemColor: const Color.fromARGB(255, 73, 73, 73),
        onTap: (index) {
          setState(() => _currentIndex = index);
          // Simple navigation example:
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
           Navigator.pushReplacementNamed(context, '/search');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/booking');
          }
          else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/favourites');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
          // Add more routes as needed
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

// ---------- Helper Widgets ----------
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;
  const _SectionHeader({required this.title, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: onViewAll,
            child: const Text(
              'View All',
              style: TextStyle(
                  color: Color.fromARGB(255, 250, 121, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String label;
  final String imageAsset;
  final VoidCallback? onTap;
  final String heroTag; // Add this

  const _CategoryCard({
    required this.label,
    required this.imageAsset,
    this.onTap, 
    String? heroTag,
    Key? key,
    // optional
  })
  : heroTag = heroTag ?? imageAsset,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // handle tap
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            child: SizedBox(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Hero(
                tag: heroTag,
                child: Image.asset(imageAsset, fit: BoxFit.cover),
              ),
            ),
          ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF23223A),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _VenueCard extends StatelessWidget {
  final String image, name, location, price, halls, capacity;
  const _VenueCard({
    required this.image,
    required this.name,
    required this.location,
    required this.price,
    required this.halls,
    required this.capacity,
  });

  @override
  Widget build(BuildContext context) {
    return _CardBase(
      image: image,
      name: name,
      location: location,
      price: price,
      halls: halls,
      capacity: capacity,
      buttonLabel: 'Show Details',
      onButtonPressed: () {
 Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VenueDetailsPage(
              image: image,
              name: name,
              location: location,
              price: price,
              halls: halls,
              capacity: capacity,
            ),
          ),
 ); 
      },
    );
  }
}

class _StageCard extends StatelessWidget {
  final String image, name, location, price, halls, capacity;
  const _StageCard({
    required this.image,
    required this.name,
    required this.location,
    required this.price,
    required this.halls,
    required this.capacity,
  });

  @override
  Widget build(BuildContext context) {
    return _CardBase(
      image: image,
      name: name,
      location: location,
      price: price,
      halls: halls,
      capacity: capacity,
      buttonLabel: 'Select',
      onButtonPressed: () {
Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VenueDetailsPage(
              image: image,
              name: name,
              location: location,
              price: price,
              halls: halls,
              capacity: capacity,
            ),
          ),
 );       },
    );
  }
}

// Re-usable card layout
class _CardBase extends StatefulWidget {
  final String image, name, location, price, halls, capacity;
  final String buttonLabel;
  final VoidCallback onButtonPressed;
  const _CardBase({
    required this.image,
    required this.name,
    required this.location,
    required this.price,
    required this.halls,
    required this.capacity,
    required this.buttonLabel,
    required this.onButtonPressed,
  });

  @override
  State<_CardBase> createState() => _CardBaseState();
}

class _CardBaseState extends State<_CardBase> {
  bool isFavourite= false;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Favorite Icon ----------
            Stack(
              children: [
                Image.asset(
                  widget.image,
                  width: double.infinity,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      setState(() => isFavourite = !isFavourite);
                      // TODO: save favourite to DB or provider if needed
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white.withOpacity(0.7),
                      child: Icon(
                        isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavourite ? Colors.red : Colors.black54,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ---------- Details ----------
            // Image.asset(widget.image, width: double.infinity, height: 80, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(widget.location,
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.currency_rupee,
                          size: 14, color: Colors.pink),
                      Text(widget.price, style: const TextStyle(fontSize: 13)),
                      const Spacer(),
                      const Icon(Icons.meeting_room,
                          size: 14, color: Colors.purple),
                      Text(' ${widget.halls}', style: const TextStyle(fontSize: 13)),
                      const Spacer(),
                      const Icon(Icons.people, size: 14, color: Colors.blue),
                      Text(' ${widget.capacity}', style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
            // ---------- Action Button ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8F5CFF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: widget.onButtonPressed,
                  child: Text(widget.buttonLabel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 