import 'package:flutter/material.dart';
import '../../core/data/herbal_data.dart';

class HerbalCareScreen extends StatefulWidget {
  @override
  _HerbalCareScreenState createState() => _HerbalCareScreenState();
}

class _HerbalCareScreenState extends State<HerbalCareScreen> {
  String selectedSymptom = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Remedies 🌿")),
      body: Column(
        children: [
          // Dropdown for symptoms
          Padding(
            padding: EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              hint: Text("Select Symptom"),
              value: selectedSymptom.isEmpty ? null : selectedSymptom,
              items: herbalData.keys.map((symptom) {
                return DropdownMenuItem(value: symptom, child: Text(symptom));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSymptom = value!;
                });
              },
            ),
          ),

          // 🔹 Show remedies
          Expanded(
            child: selectedSymptom.isEmpty
                ? Center(child: Text("Select a symptom"))
                : ListView(
                    children: herbalData[selectedSymptom]!.map<Widget>((item) {
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            item["plant"]!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Usage: ${item["usage"]}\n\nWarning: ${item["warning"]}",
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
