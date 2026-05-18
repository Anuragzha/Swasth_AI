import 'package:flutter/material.dart';

// LOCAL DATA (no Firestore)
final symptomData = [
  {
    "disease": "Flu",
    "symptoms": ["fever", "cough", "body pain"],
    "advice": "Take rest and drink fluids.",
  },
  {
    "disease": "Common Cold",
    "symptoms": ["cough", "cold", "sneezing"],
    "advice": "Drink warm fluids and rest.",
  },
  {
    "disease": "Allergy",
    "symptoms": ["itching", "rash"],
    "advice": "Avoid allergens.",
  },
  {
    "disease": "Food Poisoning",
    "symptoms": ["stomach pain", "vomiting", "diarrhea"],
    "advice": "Drink ORS and avoid outside food.",
  },
  {
    "disease": "Jaundice",
    "symptoms": ["yellow eyes", "yellow skin", "fatigue"],
    "advice": "Consult doctor immediately.",
  },
];

class SymptomCheckerScreen extends StatefulWidget {
  @override
  _SymptomCheckerScreenState createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  List<String> selectedSymptoms = [];
  String result = "";

  final allSymptoms = [
    "fever",
    "cough",
    "cold",
    "sneezing",
    "body pain",
    "headache",
    "itching",
    "rash",
    "stomach pain",
    "vomiting",
    "diarrhea",
    "yellow eyes",
    "yellow skin",
    "fatigue",
  ];

  // FIXED LOGIC
  void checkDisease() {
    if (selectedSymptoms.isEmpty) {
      setState(() {
        result = "Please select symptoms first.";
      });
      return;
    }

    int bestMatchCount = 0;
    Map<String, dynamic>? bestMatch;

    for (var item in symptomData) {
      List symptoms = item["symptoms"] as List;

      int matchCount = 0;

      for (var s in selectedSymptoms) {
        if (symptoms.contains(s)) {
          matchCount++;
        }
      }

      if (matchCount > bestMatchCount) {
        bestMatchCount = matchCount;
        bestMatch = item;
      }
    }

    if (bestMatch != null && bestMatchCount >= 2) {
      setState(() {
        result =
            "Disease: ${bestMatch!["disease"]}\n\nMatched: $bestMatchCount symptoms\n\nAdvice: ${bestMatch["advice"]}";
      });
    } else {
      setState(() {
        result = "Not enough symptoms matched. Please consult a doctor.";
      });
    }
  }

  void clearSelection() {
    setState(() {
      selectedSymptoms.clear();
      result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Symptom Checker"),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: clearSelection),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: allSymptoms.map((symptom) {
                return CheckboxListTile(
                  title: Text(symptom),
                  value: selectedSymptoms.contains(symptom),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        selectedSymptoms.add(symptom);
                      } else {
                        selectedSymptoms.remove(symptom);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: checkDisease,
              child: Text("Check Result"),
            ),
          ),

          SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.all(16),
            child: Text(result, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
