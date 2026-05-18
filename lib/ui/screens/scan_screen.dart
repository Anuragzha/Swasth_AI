import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart' as ai;

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? _image;
  String _result = "";
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  // 🔑 PASTE YOUR WORKING API KEY HERE (The one from your Chatbot)
  static const String _apiKey = 'AIzaSyB1cq0dxFRxdOix6qtYxtTw9PKXxHJbvRw';

  // 📷 Pick Image
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Reduces size for faster API processing
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _result = "";
        });
      }
    } catch (e) {
      setState(() => _result = "Error picking image: $e");
    }
  }

  // 🤖 Analyze Image using Gemini
  Future<void> _analyzeSkin() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
      _result = "";
    });

    try {
      // Using the exact same model version as your working chatbot
      final model = ai.GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: _apiKey,
        safetySettings: [
          // Medical images are often falsely flagged as "Dangerous" or "Explicit"
          // Setting to 'none' or 'high' threshold ensures the AI actually responds
          ai.SafetySetting(
            ai.HarmCategory.harassment,
            ai.HarmBlockThreshold.none,
          ),
          ai.SafetySetting(
            ai.HarmCategory.hateSpeech,
            ai.HarmBlockThreshold.none,
          ),
          ai.SafetySetting(
            ai.HarmCategory.sexuallyExplicit,
            ai.HarmBlockThreshold.none,
          ),
          ai.SafetySetting(
            ai.HarmCategory.dangerousContent,
            ai.HarmBlockThreshold.none,
          ),
        ],
      );

      final bytes = await _image!.readAsBytes();

      // Building the multimodal content (Text + Image)
      final content = [
        ai.Content.multi([
          ai.TextPart(
            "Analyze this skin condition image for educational purposes. Provide: "
            "\n1. Observed Symptoms"
            "\n2. Possible Conditions"
            "\n3. Severity (Low/Medium/High)"
            "\n4. Advice"
            "\n\nInclude a strong disclaimer that this is not a medical diagnosis.",
          ),
          ai.DataPart('image/jpeg', bytes),
        ]),
      ];

      final response = await model.generateContent(content);

      setState(() {
        _result = response.text ?? "AI could not analyze this image.";
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("API Error: $e");
      setState(() {
        _result =
            "Technical Error: $e\n\nEnsure your API key is correct and you have an internet connection.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF121212,
      ), // Dark theme to match your chatbot
      appBar: AppBar(
        title: const Text(
          "AI Skin Scanner",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Image Preview Card
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(_image!, fit: BoxFit.cover),
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_search,
                          size: 80,
                          color: Colors.white38,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "No Image Selected",
                          style: TextStyle(color: Colors.white38),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 25),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Gallery"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white10,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _image == null || _isLoading
                        ? null
                        : _analyzeSkin,
                    icon: const Icon(Icons.analytics),
                    label: const Text("Analyze"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Results Display
            if (_isLoading)
              const CircularProgressIndicator(color: Colors.blueAccent)
            else if (_result.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Analysis:",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Divider(color: Colors.white24),
                    Text(
                      _result,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 30),
            const Text(
              "This tool provides information for educational purposes and is not a substitute for professional medical advice.",
              style: TextStyle(color: Colors.redAccent, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
