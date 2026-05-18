import 'package:flutter/material.dart';
import '../../core/data/health_tips_data.dart';

class HealthTipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Health Tips")),
      body: ListView.builder(
        itemCount: healthTips.length,
        itemBuilder: (context, index) {
          final tip = healthTips[index];

          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              title: Text(
                tip["title"]!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(tip["tip"]!),
              ),
            ),
          );
        },
      ),
    );
  }
}
