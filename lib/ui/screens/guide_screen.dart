import 'package:flutter/material.dart';

class GuideScreen extends StatelessWidget {
  Widget buildCard(String title, String content, IconData icon) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: Colors.green),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    content,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Guide 📖")),
      body: ListView(
        children: [
          buildCard(
            "How to Use App",
            "Select symptoms, scan images, or explore herbal care for guidance.",
            Icons.info,
          ),
          buildCard(
            "Symptom Checker",
            "Choose your symptoms and get possible health conditions.",
            Icons.health_and_safety,
          ),
          buildCard(
            "Scan Image",
            "Capture an image to detect possible skin issues.",
            Icons.camera_alt,
          ),
          buildCard(
            "Herbal Care",
            "Get natural remedies based on common health problems.",
            Icons.local_florist,
          ),
          buildCard(
            "When to Visit Doctor",
            "If symptoms are severe or last more than 2-3 days, consult a doctor.",
            Icons.warning,
          ),
          buildCard(
            "Emergency Tips",
            "In case of serious injury or breathing problem, seek immediate help.",
            Icons.emergency,
          ),
        ],
      ),
    );
  }
}
