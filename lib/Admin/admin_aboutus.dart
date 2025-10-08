
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:project/screens/admin_home.dart';

class AdminAboutUsPage extends StatefulWidget {
  const AdminAboutUsPage({super.key});

  @override
  State<AdminAboutUsPage> createState() => _AdminAboutUsPageState();
}

class _AdminAboutUsPageState extends State<AdminAboutUsPage> {
  final TextEditingController titleController =
      TextEditingController(text: 'Welcome to Eventify');
  final TextEditingController subtitleController =
      TextEditingController(text: 'Your Premier Event Management Solution');
  final TextEditingController storyController = TextEditingController(
      text:
          'Founded in 2020, Eventify has been transforming the way people plan and manage events. We started with a simple mission: to make event planning accessible, stress-free, and enjoyable for everyone.');
  final TextEditingController feature1Controller =
      TextEditingController(text: 'Venue Booking');
  final TextEditingController feature2Controller =
      TextEditingController(text: 'Event Planning');
  final TextEditingController feature3Controller =
      TextEditingController(text: 'Decoration Services');
  final TextEditingController feature4Controller =
      TextEditingController(text: 'Catering Options');
  final TextEditingController stat1Controller =
      TextEditingController(text: '5000+ Events Organized');
  final TextEditingController stat2Controller =
      TextEditingController(text: '98% Customer Satisfaction');
  final TextEditingController stat3Controller =
      TextEditingController(text: '200+ Venue Partners');
  final TextEditingController stat4Controller =
      TextEditingController(text: '24/7 Customer Support');

  bool isEditing = true;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      titleController.text = prefs.getString('about_title') ?? titleController.text;
      subtitleController.text =
          prefs.getString('about_subtitle') ?? subtitleController.text;
      storyController.text = prefs.getString('about_story') ?? storyController.text;
      feature1Controller.text =
          prefs.getString('feature1') ?? feature1Controller.text;
      feature2Controller.text =
          prefs.getString('feature2') ?? feature2Controller.text;
      feature3Controller.text =
          prefs.getString('feature3') ?? feature3Controller.text;
      feature4Controller.text =
          prefs.getString('feature4') ?? feature4Controller.text;
      stat1Controller.text = prefs.getString('stat1') ?? stat1Controller.text;
      stat2Controller.text = prefs.getString('stat2') ?? stat2Controller.text;
      stat3Controller.text = prefs.getString('stat3') ?? stat3Controller.text;
      stat4Controller.text = prefs.getString('stat4') ?? stat4Controller.text;
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('about_title', titleController.text);
    await prefs.setString('about_subtitle', subtitleController.text);
    await prefs.setString('about_story', storyController.text);
    await prefs.setString('feature1', feature1Controller.text);
    await prefs.setString('feature2', feature2Controller.text);
    await prefs.setString('feature3', feature3Controller.text);
    await prefs.setString('feature4', feature4Controller.text);
    await prefs.setString('stat1', stat1Controller.text);
    await prefs.setString('stat2', stat2Controller.text);
    await prefs.setString('stat3', stat3Controller.text);
    await prefs.setString('stat4', stat4Controller.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('About Us details saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Edit About Us'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.blue),
            onPressed: _saveData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.jpeg',
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField("Title", titleController),
            const SizedBox(height: 10),
            _buildTextField("Subtitle", subtitleController),
            const SizedBox(height: 30),
            const Text(
              'Our Story',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTextField("Story", storyController, maxLines: 5),
            const SizedBox(height: 30),
            const Text(
              'What We Offer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildFeatureEdit("Feature 1", feature1Controller),
            _buildFeatureEdit("Feature 2", feature2Controller),
            _buildFeatureEdit("Feature 3", feature3Controller),
            _buildFeatureEdit("Feature 4", feature4Controller),
            const SizedBox(height: 30),
            const Text(
              'Why Choose Us?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildStatEdit("Stat 1", stat1Controller),
            _buildStatEdit("Stat 2", stat2Controller),
            _buildStatEdit("Stat 3", stat3Controller),
            _buildStatEdit("Stat 4", stat4Controller),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: _saveData,
                icon: const Icon(Icons.save),
                label: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildFeatureEdit(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(child: _buildTextField(label, controller)),
        ],
      ),
    );
  }

  Widget _buildStatEdit(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          const Icon(Icons.bar_chart, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(child: _buildTextField(label, controller)),
        ],
      ),
    );
  }
}
