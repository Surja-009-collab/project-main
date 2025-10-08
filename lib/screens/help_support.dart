import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final List<FAQItem> _faqs = [
    FAQItem(
      question: "How do I book an event planner for my wedding?",
      answer:
          "To book an event planner, go to the 'Plan Event' section, select 'Wedding', fill in your requirements, and our team will connect you with suitable planners within 24 hours.",
      isExpanded: false,
    ),
    FAQItem(
      question: "What types of events do you organize?",
      answer:
          "We specialize in weddings, birthdays, fashion shows, baby showers, farewell parties, corporate events, and custom events based on your requirements.",
      isExpanded: false,
    ),
    FAQItem(
      question: "How far in advance should I book an event planner?",
      answer:
          "We recommend booking at least 3-6 months in advance for weddings and large events. For smaller events, 2-4 weeks is usually sufficient.",
      isExpanded: false,
    ),
    FAQItem(
      question: "Can I customize my event package?",
      answer:
          "Yes, all our event packages are customizable. Our planners will work with you to create a personalized experience that fits your vision and budget.",
      isExpanded: false,
    ),
    FAQItem(
      question: "What's included in your basic wedding package?",
      answer:
          "Our basic wedding package includes venue selection, decor, catering for 50 guests, photography, and event coordination. Additional services can be added as needed.",
      isExpanded: false,
    ),
  ];

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _selectedInquiryType = "I need help with planning an event";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Help & Support',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            _buildSearchBar(),
            const SizedBox(height: 24),

            // Quick Help Section
            _buildQuickHelp(),
            const SizedBox(height: 24),

            // Contact Options
            _buildContactOptions(),
            const SizedBox(height: 24),

            // FAQ Section
            _buildFAQSection(),
            const SizedBox(height: 24),

            // Submit a Request
            _buildRequestForm(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
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
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for help...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        onChanged: (value) {
          // Implement search functionality
        },
      ),
    );
  }

  Widget _buildQuickHelp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Help',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildHelpCard(
                icon: Icons.favorite,
                title: 'Weddings',
                onTap: () => _navigateToWeddingGuide(),
                width: 120,
              ),
              const SizedBox(width: 12),
              _buildHelpCard(
                icon: Icons.cake,
                title: 'Birthdays',
                onTap: () => _navigateToBirthdayGuide(),
                width: 120,
              ),
              const SizedBox(width: 12),
              _buildHelpCard(
                icon: Icons.style,
                title: 'Fashion Shows',
                onTap: () => _navigateToFashionShowGuide(),
                width: 140,
              ),
              const SizedBox(width: 12),
              _buildHelpCard(
                icon: Icons.child_care,
                title: 'Baby Showers',
                onTap: () => _navigateToBabyShowerGuide(),
                width: 140,
              ),
              const SizedBox(width: 12),
              _buildHelpCard(
                icon: Icons.celebration,
                title: 'Farewell Parties',
                onTap: () => _navigateToFarewellGuide(),
                width: 140,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHelpCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required double width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.purple),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Support',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildContactOption(
                icon: Icons.chat,
                title: 'Live Chat',
                subtitle: 'Talk to us now',
                onTap: () => _startLiveChat(),
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildContactOption(
                icon: Icons.email,
                title: 'Email',
                subtitle: 'support@eventify.com',
                onTap: () => _sendEmail(),
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildContactOption(
                icon: Icons.phone,
                title: 'Call Us',
                subtitle: '+91 98765 43210',
                onTap: () => _makePhoneCall(),
                color: Colors.purple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildContactOption(
                icon: Icons.help_center,
                title: 'Help Center',
                subtitle: 'Browse articles',
                onTap: () => _openHelpCenter(),
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _faqs.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return _buildFAQItem(_faqs[index]);
          },
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => _viewAllFAQs(),
            child: const Text('View all FAQs →'),
          ),
        ),
      ],
    );
  }

  Widget _buildFAQItem(FAQItem faq) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          faq.question,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        initiallyExpanded: faq.isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            faq.isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(faq.answer, style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Submit a Request',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What do you need help with?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildInquiryChip(
                    'I need help with planning an event',
                    _selectedInquiryType ==
                        'I need help with planning an event',
                  ),
                  _buildInquiryChip(
                    'I have a question about my booking',
                    _selectedInquiryType ==
                        'I have a question about my booking',
                  ),
                  _buildInquiryChip(
                    'I want to modify my event details',
                    _selectedInquiryType == 'I want to modify my event details',
                  ),
                  _buildInquiryChip(
                    'I need to cancel my event',
                    _selectedInquiryType == 'I need to cancel my event',
                  ),
                  _buildInquiryChip(
                    'I have a billing or payment question',
                    _selectedInquiryType ==
                        'I have a billing or payment question',
                  ),
                  _buildInquiryChip(
                    'I want to provide feedback',
                    _selectedInquiryType == 'I want to provide feedback',
                  ),
                  _buildInquiryChip(
                    'Other inquiry',
                    _selectedInquiryType == 'Other inquiry',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: "Subject",
                  hintText: "Briefly describe your issue",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Your Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Please describe your issue in detail",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _submitRequest(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit Request',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInquiryChip(String label, bool isSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedInquiryType = selected ? label : _selectedInquiryType;
        });
      },
      selectedColor: Colors.purple.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? Colors.purple : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? Colors.purple : Colors.grey[300]!,
          width: isSelected ? 1.5 : 1,
        ),
      ),
    );
  }

  // Action methods
  void _navigateToWeddingGuide() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WeddingGuideScreen()),
    );
  }

  void _navigateToBirthdayGuide() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BirthdayGuideScreen()),
    );
  }

  void _navigateToFashionShowGuide() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FashionShowGuideScreen()),
    );
  }

  void _navigateToBabyShowerGuide() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BabyShowerGuideScreen()),
    );
  }

  void _navigateToFarewellGuide() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FarewellGuideScreen()),
    );
  }

  void _startLiveChat() {
    // Implement live chat functionality
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Connecting to live chat...')));
  }

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@eventify.com',
      queryParameters: {'subject': 'Eventify Support Request'},
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch email client')),
      );
    }
  }

  void _makePhoneCall() async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: '+919876543210');

    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch phone app')),
      );
    }
  }

  void _openHelpCenter() {
    // Navigate to help center
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Opening help center...')));
  }

  void _viewAllFAQs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AllFAQsScreen()),
    );
  }

  void _submitRequest() {
    if (_subjectController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    // Submit support request
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Support request submitted successfully!')),
    );

    // Clear form
    _subjectController.clear();
    _messageController.clear();
  }
}

// Wedding Guide Screen
class WeddingGuideScreen extends StatelessWidget {
  const WeddingGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Planning Guide'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wedding Planning Guide',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Design & Decor'),
            const SizedBox(height: 8),
            const Text(
              'Our designers create a custom theme and decor plan that reflects your personality. We work with you to choose colors, flowers, lighting, and all decorative elements to make your wedding truly unique.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Day-of Coordination'),
            const SizedBox(height: 8),
            const Text(
              'Our team manages everything on your wedding day so you can enjoy stress-free. We coordinate with vendors, manage the timeline, handle any issues that arise, and ensure your special day runs smoothly.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Popular Wedding Packages'),
            const SizedBox(height: 16),
            _buildPackageCard(
              title: 'Basic Package',
              price: '₹89,999',
              includes: [
                'Venue selection',
                'Basic decor',
                'Coordination for 50 guests',
              ],
            ),
            _buildPackageCard(
              title: 'Premium Package',
              price: '₹1,99,999',
              includes: [
                'Premium venue',
                'Custom decor',
                'Full vendor coordination',
                'Photography',
              ],
            ),
            _buildPackageCard(
              title: 'Luxury Package',
              price: '₹3,49,999',
              includes: [
                'Luxury venue',
                'Premium decor',
                'Complete planning',
                'Videography',
                'Entertainment',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }

  Widget _buildPackageCard({
    required String title,
    required String price,
    required List<String> includes,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Includes:',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: includes.map((item) => _buildIncludedItem(item)).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Select Package'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}

// Birthday Guide Screen
class BirthdayGuideScreen extends StatelessWidget {
  const BirthdayGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Birthday Planning Guide'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Birthday Party Planning',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'We specialize in creating memorable birthday experiences for all ages. Our services include theme selection, venue booking, catering, entertainment, and decor.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Our Birthday Packages'),
            const SizedBox(height: 16),
            _buildPackageCard(
              title: 'Kids Birthday Package',
              price: '₹24,999',
              includes: [
                'Theme decoration',
                'Entertainment',
                'Cake',
                'Food for 20 children',
              ],
            ),
            _buildPackageCard(
              title: 'Adult Birthday Package',
              price: '₹39,999',
              includes: [
                'Venue decoration',
                'Catering',
                'Music',
                'Photography',
              ],
            ),
            _buildPackageCard(
              title: 'Special Milestone Package',
              price: '₹69,999',
              includes: [
                'Premium venue',
                'Custom theme',
                'Professional photography',
                'Videography',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }

  Widget _buildPackageCard({
    required String title,
    required String price,
    required List<String> includes,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Includes:',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: includes.map((item) => _buildIncludedItem(item)).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Select Package'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}

// Fashion Show Guide Screen
class FashionShowGuideScreen extends StatelessWidget {
  const FashionShowGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fashion Show Planning Guide'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fashion Show Production',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'From runway design to model coordination, we handle all aspects of fashion show production. Our services include venue selection, lighting, sound, and backstage management.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Our Fashion Show Packages'),
            const SizedBox(height: 16),
            _buildPackageCard(
              title: 'Basic Runway Show',
              price: '₹1,49,999',
              includes: [
                'Venue setup',
                'Basic lighting',
                'Sound system',
                'Backstage coordination',
              ],
            ),
            _buildPackageCard(
              title: 'Premium Fashion Event',
              price: '₹2,99,999',
              includes: [
                'Premium venue',
                'Professional lighting',
                'HD Photography',
                'Model coordination',
              ],
            ),
            _buildPackageCard(
              title: 'Luxury Fashion Show',
              price: '₹4,99,999',
              includes: [
                'Luxury venue',
                'Custom runway',
                'Professional videography',
                'Celebrity management',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }

  Widget _buildPackageCard({
    required String title,
    required String price,
    required List<String> includes,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Includes:',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: includes.map((item) => _buildIncludedItem(item)).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Select Package'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}

// Baby Shower Guide Screen
class BabyShowerGuideScreen extends StatelessWidget {
  const BabyShowerGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby Shower Planning Guide'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Baby Shower Celebrations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Create beautiful memories with our baby shower planning services. We offer theme development, venue decoration, catering, and games tailored to your preferences.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Our Baby Shower Packages'),
            const SizedBox(height: 16),
            _buildPackageCard(
              title: 'Simple Celebration',
              price: '₹19,999',
              includes: [
                'Basic decoration',
                'Invitations',
                'Simple catering',
                'Games',
              ],
            ),
            _buildPackageCard(
              title: 'Premium Baby Shower',
              price: '₹34,999',
              includes: [
                'Theme decoration',
                'Custom invitations',
                'Premium catering',
                'Photography',
              ],
            ),
            _buildPackageCard(
              title: 'Luxury Celebration',
              price: '₹59,999',
              includes: [
                'Luxury venue',
                'Custom theme',
                'Professional photography',
                'Videography',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }

  Widget _buildPackageCard({
    required String title,
    required String price,
    required List<String> includes,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Includes:',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: includes.map((item) => _buildIncludedItem(item)).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Select Package'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}

// Farewell Guide Screen
class FarewellGuideScreen extends StatelessWidget {
  const FarewellGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farewell Party Planning Guide'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Farewell Party Planning',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Create memorable farewell parties that celebrate achievements and mark new beginnings. Our services include theme development, venue selection, catering, and personalized touches to make the event special.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Our Farewell Party Packages'),
            const SizedBox(height: 16),
            _buildPackageCard(
              title: 'Basic Farewell',
              price: '₹14,999',
              includes: [
                'Venue decoration',
                'Basic catering',
                'Music setup',
                'Photo corner',
              ],
            ),
            _buildPackageCard(
              title: 'Premium Farewell',
              price: '₹29,999',
              includes: [
                'Themed decoration',
                'Premium catering',
                'Professional photography',
                'Audio-visual setup',
              ],
            ),
            _buildPackageCard(
              title: 'Corporate Farewell',
              price: '₹49,999',
              includes: [
                'Luxury venue',
                'Custom theme',
                'Videography',
                'Speeches coordination',
                'Gift presentation',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }

  Widget _buildPackageCard({
    required String title,
    required String price,
    required List<String> includes,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Includes:',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: includes.map((item) => _buildIncludedItem(item)).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Select Package'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}

// All FAQs Screen
class AllFAQsScreen extends StatelessWidget {
  const AllFAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All FAQs'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildFAQCategory(
              title: 'Booking & Planning',
              faqs: [
                FAQItem(
                  question: 'How do I book an event planner?',
                  answer:
                      'You can book an event planner through our app by selecting the type of event, date, and requirements. Our team will contact you within 24 hours.',
                  isExpanded: false,
                ),
                FAQItem(
                  question: 'How far in advance should I book?',
                  answer:
                      'We recommend booking at least 3-6 months in advance for weddings and large events. For smaller events, 2-4 weeks is usually sufficient.',
                  isExpanded: false,
                ),
                FAQItem(
                  question: 'Can I make changes to my booking?',
                  answer:
                      'Yes, you can make changes to your booking up to 2 weeks before the event. Changes may be subject to additional fees depending on the nature of the change.',
                  isExpanded: false,
                ),
              ],
            ),
            _buildFAQCategory(
              title: 'Pricing & Payments',
              faqs: [
                FAQItem(
                  question: 'What is included in your pricing?',
                  answer:
                      'Our pricing includes planning services, vendor coordination, and day-of coordination. Additional costs may include venue rental, catering, and other vendor services.',
                  isExpanded: false,
                ),
                FAQItem(
                  question: 'What payment methods do you accept?',
                  answer:
                      'We accept credit cards, debit cards, bank transfers, and mobile payment options. Payment plans are available for larger events.',
                  isExpanded: false,
                ),
                FAQItem(
                  question: 'Do you offer refunds?',
                  answer:
                      'Refunds are available according to our cancellation policy. Typically, cancellations made more than 30 days before the event receive a full refund minus a processing fee.',
                  isExpanded: false,
                ),
              ],
            ),
            _buildFAQCategory(
              title: 'Event Services',
              faqs: [
                FAQItem(
                  question: 'What types of events do you organize?',
                  answer:
                      'We specialize in weddings, birthdays, fashion shows, baby showers, farewell parties, corporate events, and custom events based on your requirements.',
                  isExpanded: false,
                ),
                FAQItem(
                  question: 'Do you provide vendors or can I bring my own?',
                  answer:
                      'We have a network of trusted vendors, but you are welcome to bring your own vendors. Our planners will coordinate with them to ensure everything runs smoothly.',
                  isExpanded: false,
                ),
                FAQItem(
                  question: 'Can you help with destination events?',
                  answer:
                      'Yes, we offer destination event planning services. Additional fees may apply for travel and accommodation arrangements.',
                  isExpanded: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQCategory({
    required String title,
    required List<FAQItem> faqs,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: faqs.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return _buildFAQItem(faqs[index]);
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildFAQItem(FAQItem faq) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          faq.question,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        initiallyExpanded: faq.isExpanded,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(faq.answer, style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }
}

class FAQItem {
  String question;
  String answer;
  bool isExpanded;

  FAQItem({
    required this.question,
    required this.answer,
    required this.isExpanded,
  });
}