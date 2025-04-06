import 'package:flutter/material.dart';
import 'onboarding_tabs_page.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String _selectedLanguage = 'English';

  final Map<String, String> startButtonTexts = {
    'English': 'Get Started',
    'Hindi': 'शुरू करें',
    'Bengali': 'শুরু করুন',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Language")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Choose Your Language",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedLanguage,
              items: ['English', 'Hindi', 'Bengali']
                  .map((lang) => DropdownMenuItem<String>(
                        value: lang,
                        child: Text(lang),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() => _selectedLanguage = val!);
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          OnboardingTabsPage(language: _selectedLanguage)),
                );
              },
              child: Text(startButtonTexts[_selectedLanguage]!),
            ),
          ],
        ),
      ),
    );
  }
}
