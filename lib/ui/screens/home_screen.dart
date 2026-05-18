import 'package:flutter/material.dart';
import 'package:swasthai/ui/screens/health_tips_screen.dart';
import 'package:swasthai/ui/screens/symptom_checker_screen.dart';
import '../widgets/feature_card.dart';
import 'auth/login_screen.dart';
import 'profile_screen.dart';
import 'first_aid_detail_screen.dart';
import 'scan_screen.dart';
import 'herbal_care_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  HomeScreen({required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> _screens() => [
    _homeContent(),
    _aboutScreen(),
    _sosScreen(),
    _guideScreen(),
  ];

  Widget _homeContent() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            "Welcome, ${widget.username}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              //  FIX: Added onTap
              buildCard("Symptom Checker", Icons.health_and_safety, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SymptomCheckerScreen()),
                );
              }),

              //  MAIN FIX: Scan Image now clickable
              buildCard("Scan Image", Icons.camera_alt, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ScanScreen()),
                );
              }),

              //  FIX: Added onTap
              buildCard("Herbal Remedies", Icons.local_florist, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HerbalCareScreen()),
                );
              }),

              // ✅ FIX: Added onTap
              buildCard("Health Tips", Icons.menu_book, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HealthTipsScreen()),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  // ================= ABOUT SCREEN =================

  Widget _aboutScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.health_and_safety,
                  size: 60,
                  color: Color(0xFF2E7D32),
                ),
                SizedBox(height: 10),
                Text(
                  "SwasthAI",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Your Offline Health Assistant",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          _sectionCard(
            "About App",
            "SwasthAI provides offline healthcare guidance. It helps users understand symptoms, perform first aid, and access emergency support in rural areas.",
          ),

          _sectionCard(
            "Key Features",
            "",
            isList: true,
            listData: [
              "Symptom-based disease prediction",
              "Image-based analysis",
              "Offline first aid guidance",
              "Emergency SOS support",
              "Health awareness tips",
            ],
          ),

          _sectionCard(
            "Why SwasthAI?",
            "",
            isList: true,
            listData: [
              "Works without internet",
              "Simple and easy to use",
              "Designed for rural areas",
              "Quick emergency help",
            ],
          ),

          _sectionCard(
            "Important Note",
            "This app is not a replacement for a doctor. In serious conditions, always seek medical help.",
          ),

          _sectionCard(
            "Administrative Details",
            "",
            isList: true,
            listData: [
              "Developer: YakMind Squad",
              "Version: 1.0.0",
              "Release Date: 20 April 2026",
              "Copyright@2026 SwasthAI. All rights reserved By YakMind Squad.",
            ],
          ),
        ],
      ),
    );
  }

  // ================= SOS SCREEN =================

  Widget _sosScreen() {
    final firstAidData = {
      "Fever": {
        "problem": "Increase in body temperature due to infection.",
        "symptoms": ["High temperature", "Sweating", "Weakness", "Headache"],
        "precautions": ["Avoid cold exposure", "Do not ignore high fever"],
        "steps": [
          "Take rest",
          "Drink plenty of fluids",
          "Use paracetamol if needed",
          "Monitor temperature regularly",
        ],
        "doctor": "If fever lasts more than 2-3 days or very high",
      },
    };

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          "Emergency Helplines",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        ListTile(title: Text("Ambulance"), trailing: Text("102")),
        ListTile(title: Text("Police"), trailing: Text("100")),
        ListTile(title: Text("Fire"), trailing: Text("101")),

        SizedBox(height: 20),

        Text(
          "Quick First Aid",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        ...firstAidData.keys.map((key) {
          return Card(
            child: ListTile(
              title: Text(key),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FirstAidDetailScreen(
                      title: key,
                      data: firstAidData[key]!,
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  // ================= GUIDE =================

  Widget _guideScreen() {
    return Center(child: Text("Guide Screen"));
  }

  //  THIS FUNCTION IS CORRECT (NO CHANGE)
  Widget buildCard(String title, IconData icon, VoidCallback onTap) {
    return FeatureCard(title: title, icon: icon, onTap: onTap);
  }

  Widget _sectionCard(
    String title,
    String content, {
    bool isList = false,
    List<String>? listData,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          if (!isList)
            Text(content)
          else
            Column(
              children: listData!
                  .map(
                    (e) => Row(
                      children: [
                        Icon(Icons.check, color: Colors.green, size: 18),
                        SizedBox(width: 6),
                        Expanded(child: Text(e)),
                      ],
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  // ================= MAIN =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SwasthAI"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileScreen(username: widget.username),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: "SOS"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Guide"),
        ],
      ),
    );
  }
}
