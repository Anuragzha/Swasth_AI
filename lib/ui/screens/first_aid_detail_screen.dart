import 'package:flutter/material.dart';

class FirstAidDetailScreen extends StatelessWidget {
  final String title;
  final Map<String, dynamic> data;

  FirstAidDetailScreen({required this.title, required this.data});

  Widget sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget bulletList(List<String> items) {
    return Column(
      children: items
          .map(
            (e) =>
                ListTile(leading: Icon(Icons.circle, size: 8), title: Text(e)),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Problem"),
            Text(data["problem"]),

            sectionTitle("Symptoms"),
            bulletList(List<String>.from(data["symptoms"])),

            sectionTitle("Precautions"),
            bulletList(List<String>.from(data["precautions"])),

            sectionTitle("What to Do"),
            bulletList(List<String>.from(data["steps"])),

            sectionTitle("When to Visit Doctor"),
            Text(data["doctor"]),
          ],
        ),
      ),
    );
  }
}
